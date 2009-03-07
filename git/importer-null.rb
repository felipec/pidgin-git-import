require 'git/importer'
require 'helper'

module Git

  class ExportCommit

    def git_export
      return if git_id
      get_details
      puts commit()
    end

  end

  class Importer

    def export_tags
      tags = @mtn.get_tags()
      tags.each do |k,v|
        puts "git tag #{k} mtn/#{v}"
      end
    end

  end

end
