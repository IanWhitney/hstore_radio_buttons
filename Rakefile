require "bundler/gem_tasks"
require 'rake/testtask'

Rake::TestTask.new do |t|
  t.test_files = FileList['test/lib/hstore_radio_buttons/*_test.rb']
  t.verbose = true
end

task :default => :test
