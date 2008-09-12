require 'date'

module Mtn

  $revisions = {}

  def Mtn.get_revision(id)
    $revisions[id] ||= Revision.new(id)
  end

  class Revision
    attr_reader :id, :branches
    attr_accessor :committer
    attr_accessor :body, :date, :author

    def initialize(id)
      @id = id
      @branches = []
      @parents = nil
      @childs = nil
    end

    def to_s
      @id
    end

    def inspect
      return "id=#{@id}, author=#{@author}, date=#{@date}"
    end

    def get_details
      rows = $db.execute("select id,name,value,keypair from revision_certs where id == '#{@id}'")
      rows.each do |e|
        id, name, value, keypair = e
        @committer = keypair if not @changelog and name == "changelog"
        self[name] = value
      end
    end

    def parents()
      if not @parents
        @parents = []
        rows = $db.execute("select parent,child from revision_ancestry where child == '#{@id}'")
        rows.each do |e|
          parent, child = e

          @parents << $revisions[parent] if $revisions[parent]
        end
      end
      return @parents
    end

    def childs()
      if not @childs
        @childs = []
        rows = $db.execute("select parent,child from revision_ancestry where parent == '#{@id}'")
        rows.each do |e|
          parent, child = e
          @childs << $revisions[child] if $revisions[child]
        end
      end
      return @childs
    end

    def []=(name, value)
      case name
      when "branch"
        @branches << value
      when "changelog"
        @body = value if not @body
      when "date"
        @date = Time.xmlschema(value) if not @date
      when "author"
        @author = value if not @author
      end
    end

  end

end
