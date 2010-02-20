require 'test/unit'

require 'rubygems'
require 'active_record'
require 'action_controller'
require 'action_view/test_case'

$:.unshift File.join(File.dirname(__FILE__), '..', 'lib')

require File.join(File.dirname(__FILE__), '..', 'init')

ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :database => ":memory:")
