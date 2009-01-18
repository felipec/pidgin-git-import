require 'rubygems'
require 'sqlite3'

$db = SQLite3::Database.new(ENV['MTN_DATABASE'])
