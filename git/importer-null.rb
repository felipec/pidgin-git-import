require 'git/importer'
require 'helper'

module Git

  class ExportCommit

    def git_export
      return if git_id
      get_details
      begin
        puts commit()
      rescue ParentError
      end
    end

    def check_authors
      get_details
      puts @author if not Mtn.get_real_name(@author)
      puts @committer if not Mtn.get_real_name(@committer)
    end

  end

  class Importer

    def export_tags
      tags = @mtn.get_tags()
      tags.each do |k,v|
        puts "git tag #{k} mtn/#{v}"
      end
    end

    def check_authors()
      list = export_list()

      list.each do |e|
        e.meta.check_authors
      end
    end

  end

end
