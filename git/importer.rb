require 'mtn/authors'
require 'util'

class Time
  def to_s()
    return strftime("%s %z")
  end
end

class Array
  alias :traverse :each
end

class Mtn::Revision
  def meta()
    @meta ||= Git::ExportCommit.new(self)
  end
end

module Git

  class ExportCommit

    def initialize(commit)
      @id = commit.id
      @original = commit
      ENV["TZ"] = "UTC" # so Time.to_s uses UTC
    end

    def git_id()
      return @git_id if @git_id
      @git_id = `git show-ref -s mtn/#{@id}`.chomp
      @git_id = nil if @git_id == ""
      # if File.exist?("#{$git_dir}/refs/mtn/#{@id}")
      #  @git_id = File.open("#{$git_dir}/refs/mtn/#{@id}") { |f| f.read }.chomp
      # end
      return @git_id
    end

    private

    def get_details
      @original.get_details
      @author = @original.author
      @committer = @original.committer
      @body = @original.body
      @date = @original.date
    end

=begin
    def signatures()
      tmp = []
      tmp << get_full_id(@author)
      tmp << get_full_id(@committer) if @author != @committer
      return tmp
    end

    def message()
      tmp = []

      tmp << @body if @body
      tmp << signatures.map { |e| "Signed-off-by: #{e}" }.join("\n")

      return tmp.join("\n\n");
    end
=end

    def message()
      return @body
    end

    def commit(tree = nil)
      lines = []
      lines << "tree #{tree}" if tree
      @original.parents.each do |e|
        p = Mtn.get_revision(e)
        lines << "parent #{p.meta.git_id}"
      end
      lines << "author #{Mtn.get_full_id(@author)} #{@date}"
      lines << "committer #{Mtn.get_full_id(@committer)} #{@date}"
      commit = "%s\n\n%s" % [lines.join("\n"), message]
    end

  end

  def get_revisions
  end

  class Importer
    def initialize
      get_revisions
    end

    def init
      system "git init"
      system "git config core.bare false"
    end

    def export(options = {})
      @count = 0

      if options[:revisions]
        list = []
        options[:revisions].each do |r|
          list << Mtn.get_revision(r)
        end
      else
        list = export_list(options[:heads])
      end

      list.each do |e|
        @count += 1
        $stderr.puts "== %0.2f%% (%d/%d) generating %s ==\n" % [ (100.0 * @count) / list.length, @count, list.length, e ]
        e.meta.git_export
      end
    end
  end

end
