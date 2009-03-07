require 'rubygems'
require 'sqlite3'

module Mtn

  $db = SQLite3::Database.new(ENV['MTN_DATABASE'])

end
