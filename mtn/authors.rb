module Mtn

  def Mtn.get_full_id(id)
    return "#{get_real_name(id)} <#{id}>"
  end

  private

  def Mtn.get_author_map
    @map = {}

    return if not ENV['AUTHOR_MAP']

    File.open(ENV['AUTHOR_MAP']) do |f|
      f.each do |line|
        r = line.scan /(.*) = (.*) <(.*)>/
          next if r.empty?
        id, real_name, email = r[0]
        @map[id] = real_name
      end
    end
  end

  def Mtn.get_real_name(id)
    get_author_map if @map == nil
    return @map[id] ? @map[id] : "Unknown"
  end

end
