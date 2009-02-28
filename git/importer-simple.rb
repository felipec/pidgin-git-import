require 'git/importer'
require 'helper'

class Mtn::Revision
  attr_accessor :traveled
end

module Git

  class ExportCommit

    def git_export
      return if git_id
      get_details

      fork do
        exec "mtn update --revision #{@id} --branch #{@original.branches.first} --reallyquiet"
      end
      Process.wait
      raise StandardError, "mtn error" if $?.to_i != 0
      system "git ls-files --modified --others --exclude-standard -z | git update-index --add --remove -z --stdin"
      tree = `git write-tree`.chomp
      raw_commit = commit(tree)
      puts raw_commit
      File.open("/tmp/commit.txt", "w") { |f| f.write raw_commit }
      @git_id = `git hash-object -t commit -w --stdin < /tmp/commit.txt`.chomp
      system "git update-ref refs/mtn/#{@id} #{@git_id}"
      @original.branches.each do |e|
        system "git update-ref refs/heads/#{e} #{@git_id}"
      end
    end

  end

  class Importer

    def initialize
      @wd = ENV['MTN_WORKINGDIR']
      get_revisions
    end

    def get_revisions
      @list = $list
      @mtn = Mtn::Db.new(ENV['MTN_DATABASE'])
    end

    def init
      git_dir = ENV['GIT_DIR']
      system "git init --quiet"
      system "git config core.bare false"
      File.open("#{git_dir}/info/exclude", "w") do |f|
        f.write "_MTN\n"
      end
    end

    def export(options = {})
      @count = 0

      Dir.push @wd

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
        $stderr.puts "== mtn/#{e}: #{@count} =="
        #$stderr.puts "== %0.2f%% (%d/%d) generating %s ==\n" % [ (100.0 * @count) / list.length, @count, list.length, e ]
        e.meta.git_export
      end

      Dir.pop
    end

  end

end
