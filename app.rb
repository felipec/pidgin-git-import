#!/usr/bin/env ruby

require 'mtn/repo'
require 'mtn/revision'
require 'git/importer-simple'
require 'git/importer-fast'

case ARGV[0]
when "clone"
  r = Mtn::Repo.new
  $stderr.puts "Getting mtn revisions"
  $list = r.get_all
  git = Git::Importer.new
  git.init
  $stderr.puts "Importing mtn revisions"
  git.export
  $stderr.puts "Finished"
when "update"
  r = Mtn::Repo.new
  $stderr.puts "Getting mtn revisions"
  $list = r.get_all
  git = Git::Importer.new
  $stderr.puts "Importing mtn revisions"
  git.export
  $stderr.puts "Finished"
when "export-tags"
  git = Git::Importer.new
  $stderr.puts "Exporting tags"
  git.export_tags
  $stderr.puts "Finished"
when "clone-fast"
  r = Mtn::Repo.new
  $stderr.puts "Getting mtn revisions"
  $list = r.get_all
  git = Git::FastImporter.new
  git.init
  $stderr.puts "Importing mtn revisions (fast)"
  git.export
  $stderr.puts "Finished"
end
