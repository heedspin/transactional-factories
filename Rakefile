require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "heedspin-transactional-factories"
    gem.summary = "Using nested-transactions to initialize test data programmatically."
		gem.description = "Transactional-factories uses nested-transactions (like transactional fixtures) to allow efficient initialization of test data programmatically (unlike transactional fixtures)."
    gem.email = "tim.harrison@yahoo.com"
    gem.homepage = "http://github.com/heedspin/transactional-factories"
    gem.authors = ["Tim Harrison"]
  end
  Jeweler::RubyforgeTasks.new
rescue LoadError
  puts "Jeweler gem is missing"
end

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'test'
  test.pattern = 'test/**/*_test.rb'
  test.verbose = true
end

task :test => :check_dependencies

task :default => :test