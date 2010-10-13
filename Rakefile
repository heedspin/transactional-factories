require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "transactional-factories"
		gem.summary = "Using nested-transactions to allow efficient, programmatic initialization of test data"
		gem.description = gem.summary
    gem.email = "tim.harrison@yahoo.com"
    gem.homepage = "http://open.wested.org/testing/2010/03/22/transactional-factories.html"
    gem.homepage = "http://github.com/heedspin/transactional-factories"
    gem.authors = ["Andrew Carpenter", "Tim Harrison"]
    gem.add_dependency('activesupport', '>= 2.3.2')
    gem.add_dependency('activerecord', '>= 2.3.2')
    gem.files.exclude '.gitignore'
  end
  Jeweler::RubyforgeTasks.new
rescue LoadError
  puts "Jeweler gem is missing"
end

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'test'
  test.pattern = 'test/unit/**/*_test.rb'
  test.verbose = true
end

task :test => :check_dependencies

task :default => :test
