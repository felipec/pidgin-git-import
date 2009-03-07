#!/usr/bin/env ruby

require 'mtn/repo'
require 'mtn/revision'

case ARGV[0]
when "clone"
  require 'git/importer-simple'

  r = Mtn::Repo.new
  $stderr.puts "Getting mtn revisions"
  $list = r.get_all
  git = Git::Importer.new
  git.init
  $stderr.puts "Importing mtn revisions"
  git.export
  $stderr.puts "Finished"
when "update"
  require 'git/importer-simple'

  r = Mtn::Repo.new
  $stderr.puts "Getting mtn revisions"
  $list = r.get_all
  git = Git::Importer.new
  $stderr.puts "Importing mtn revisions"
  git.export
  $stderr.puts "Finished"
when "missing-authors"
  require 'git/importer-null'

  r = Mtn::Repo.new
  $stderr.puts "Getting mtn revisions"
  $list = r.get_all
  git = Git::Importer.new
  $stderr.puts "Importing mtn revisions"
  git.check_authors
  $stderr.puts "Finished"
when "export-tags"
  require 'git/importer-null'

  git = Git::Importer.new
  $stderr.puts "Exporting tags"
  git.export_tags
  $stderr.puts "Finished"
end
