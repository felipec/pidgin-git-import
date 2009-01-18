require 'time'
require 'mtn/revision'
require 'mtn/db'

module Mtn

  class RevisionList

    def initialize()
      @revisions = {}
      @heads = nil
    end

    def add(commit)
      @revisions[commit.id] = commit
    end

    def length
      return @revisions.length
    end

    def heads()
      if not @heads
        @heads = []
        rows = $db.execute("select revisions.id from revisions left join
                           revision_ancestry on revisions.id = revision_ancestry.parent
                           where revision_ancestry.child is null")
        rows.each do |e|
          @heads << $revisions[e.first.unpack("H*").to_s]
        end
      end
      return @heads
    end
  end

  class Repo

    def get_all
      list = RevisionList.new
      rows = $db.execute("select id from revisions")
      rows.each do |e|
        id = e.first.unpack("H*").to_s
        commit = Revision.new(id)
        $revisions[id] = commit
        list.add(commit)
      end
      return list
    end
  end

end
