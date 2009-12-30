require 'test/unit'
require 'rubygems'
require 'active_record'

ActiveRecord::Base.logger = Logger.new(STDOUT)
ActiveRecord::Base.colorize_logging = false

ActiveRecord::Base.establish_connection( { :adapter => 'mysql', :database => 'test' } )
ActiveRecord::Base.connection.recreate_database('transactional_factories_test')
ActiveRecord::Base.clear_active_connections!
ActiveRecord::Base.establish_connection( { :adapter => 'mysql', :database => 'transactional_factories_test' } )

load File.dirname(__FILE__) + '/db/schema.rb'
$:.push File.dirname(__FILE__) + '/lib'
$:.push File.dirname(__FILE__) + '/../lib'
