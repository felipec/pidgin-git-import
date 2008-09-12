#!/usr/bin/env ruby

require 'mtn/repo'
require 'mtn/revision'
require 'git/importer-fast'

r = Mtn::Repo.new
$stderr.puts "Getting mtn revisions"
$list = r.get_all
git = Git::Importer.new
$stderr.puts "Importing mtn revisions"
git.export
$stderr.puts "Finished"
