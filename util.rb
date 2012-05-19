def run_query(query)
  result = `mtn db --db pidgin.mtn execute '#{query}'`
  result.split($/)[2..-1].each do |a|
    next if a.empty?
    yield a.split(" | ")
  end
end

def for_each_author()
  run_query 'select k.name,count(*) from revision_certs c join public_keys k on c.keypair_id = k.id where c.name="author" group by value' do |id, count|
    yield id, count
  end
  run_query 'select value,count(*) from revision_certs where name="author" group by value' do |id, count|
    yield id, count
  end
end

def load_authors_map
  map = {}
  File.open('authors_map.txt').each do |l|
    l.scan(/(.*) = (.*) <(.*)>/) do |id,name,email|
      map[id] = name
    end
  end
  map
end
