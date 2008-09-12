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
      @git_id = `git write-raw < /tmp/commit.txt`.chomp
      system "git update-ref refs/mtn/#{@id} #{@git_id}"
      @original.branches.each do |e|
        system "git update-ref refs/heads/#{e} #{@git_id}"
      end
    end

  end

  class Importer

    def initialize(dir)
      @dir = dir
      $git_dir = dir
      @wd = ENV['MTN_WORKINGDIR']
      ENV['GIT_DIR'] = dir
      get_revisions
    end

    def get_revisions
      @list = $list
      @mtn = Mtn::Db.new(ENV['MTN_DATABASE'])
    end

    def init
      system "git init"
      system "git config core.bare false"
      File.open("#{@dir}/info/exclude", "w") do |f|
        f.write "_MTN\n"
      end
    end

    def export_list
      def travel(c)
        return [] if c.traveled
        $stderr.puts "%s -> %s" % [c.id, c.meta.git_id]
        return [] if c.meta.git_id
        list = []
        c.traveled = true
        c.parents.each do |e|
          list += travel(e)
        end

        return list.push(c)
      end

      list = []
      heads = @mtn.get_heads()
      heads.each do |e|
        head = Mtn.get_revision(e)
        list += travel(head)
      end

      return list
    end

    def export
      @count = 0

      Dir.push @wd

      list = export_list()

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
