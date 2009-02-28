require 'git/importer'
require 'helper'

class FileAction
  attr_reader :action
  attr_accessor :name, :new_name
  attr_accessor :exec, :mark

  def initialize(action, fn, args = {})
    @action = action
    @name = fn
    @new_name = args[:new_name] if args[:new_name]
=begin
    case action
    when :modify
      $stderr.puts "modify file #{fn}"
    when :add
      $stderr.puts "add file #{fn}"
    when :delete
      $stderr.puts "delete file #{fn}"
    when :rename
      $stderr.puts "rename blob #{fn} -> #{@new_name}"
    end
=end
  end
end

class MtnIO
  def initialize
    db = ENV['MTN_DATABASE']
    @pipe = IO.popen("mtn automate --db #{db} stdio", "w+")
  end

  def get_revision(id)
    @pipe.write("l12:get_revision40:#{id}e")
    get_data
  end

  def get_manifest_of(id)
    @pipe.write("l15:get_manifest_of40:#{id}e")
    get_data
  end

  def get_file(id)
    @pipe.print("l8:get_file40:#{id}e")
    get_data
  end

  private
  def get_data
    data = ""
    while true
      id = @pipe.readline(":")
      error = @pipe.readline(":")
      type = @pipe.readline(":").chomp(":")
      size = @pipe.readline(":").chomp(":").to_i
      data << @pipe.read(size)
      break if type == "l"
    end
    return data
  end
end

module Mtn

  class Revision
    attr_accessor :traveled
    attr_writer :mark

    def mark
      return ":#{@mark}" if @mark
      return @meta.git_id
    end

  end

end

$mtn = MtnIO.new
$mark = 1

module Git

  class FastImporter < Importer
    attr_writer :pipe

    def initialize
      @mtn = Mtn::Db.new(ENV['MTN_DATABASE'])
    end

    def export(options = {})
      @count = 0

      @pipe = IO.popen("git fast-import --date-format=rfc2822 --tolerant", "w+")

      if options[:revisions]
        list = []
        revisions.each do |r|
          list << Mtn.get_revision(r)
        end
      else
        list = export_list(options[:heads])
      end

      list.each do |e|
        @count += 1
        # $stderr.puts "== mtn/#{e}: #{@count} =="
        fast_revision_export(e)
        if (@count % 500 == 0)
          $stderr.puts "== %0.2f%% (%d/%d) generating %s ==\n" % [ (100.0 * @count) / list.length, @count, list.length, e ]
          @pipe.puts "checkpoint"
        end
      end

      @pipe.close
    end

    def new_blob(id, mark)
      # $stderr.puts "new blob: #{id}"
      data = $mtn.get_file(id)
      @pipe.puts "blob\nmark :#{mark}\ndata #{data.length}\n#{data}"
    end

    def fast_revision_export(r)
      r.get_details
      file_actions = {}

      tmp = $mtn.get_revision(r.id)
      tmp.split("\n\n").each do |l|
        case l
        when /^patch /
          match = l.match('^patch "([^"]+)"\n from .([a-f0-9]+).\n   to .([a-f0-9]+).')
          name = match[1]
          fa = file_actions[name] ||= FileAction.new(:modify, name)
          fa.mark = $mark += 1
          new_blob(match[3], fa.mark)
        when /^add_file /
          match = l.match('^add_file "([^"]+)"\n content .([a-f0-9]+).')
          name = match[1]
          fa = file_actions[name] ||= FileAction.new(:add, name)
          fa.mark = $mark += 1
          new_blob(match[2], fa.mark)
        when /^delete /
          match = l.match('^delete "([^"]+)"')
          name = match[1]
          file_actions[name] = FileAction.new(:delete, name)
        when /^rename /
          match = l.match('^rename "([^"]+)"\n    to "([^"]+)"')
          name = match[1]
          new_name = match[2]
          file_actions[name] = FileAction.new(:rename, name, :new_name => new_name)
        when /^  set /
          match = l.match('^  set "([^"]+)"\n attr "mtn:execute"\nvalue "([^"]+)"')
          next if not match
          name = match[1]
          fa = file_actions[name] ||= FileAction.new(:chattr, name)
          fa.exec = (match[2] == "true") ? true : false
        when /^clear /
          match = l.match('^clear "([^"]+)"\n attr "mtn:execute"')
          next if not match
          name = match[1]
          fa = file_actions[name] ||= FileAction.new(:chattr, name)
          fa.exec = false
        when /^add_dir /
          match = l.match('^add_dir "([^"]*)"')
          name = match[1]
        end
      end

      files_text = ""

      file_actions.each_value do |fa|
        case fa.action
        when :modify, :add, :chattr
          if fa.exec == nil
            perms = "-"
          else
            perms = fa.exec ? "100755" : "100644"
          end
          ref = fa.mark ? ":#{fa.mark}" : "-"
          files_text << "M #{perms} #{ref} #{fa.name}\n"
        when :delete
          files_text << "D #{fa.name}\n"
        when :rename
          files_text << "R #{fa.name} #{fa.new_name}\n"
        end
      end

      r.mark = $mark += 1
      branch = r.branches.first || "unknwon"
      @pipe.puts "commit refs/heads/#{branch}"
      @pipe.puts "mark #{r.mark}"
      @pipe.puts "author #{Mtn.get_full_id(r.author)} #{r.date.rfc2822}"
      @pipe.puts "committer #{Mtn.get_full_id(r.committer)} #{r.date.rfc2822}"
      @pipe.puts "data #{r.body.length}"
      @pipe.puts r.body

      if not r.parents.empty?
        parents = r.parents.clone
        p = parents.shift
        @pipe.puts "from #{p.mark}"

        parents.each do |p|
          @pipe.puts "merge #{p.mark}"
        end
      end

      @pipe.puts files_text
    end

  end

end
