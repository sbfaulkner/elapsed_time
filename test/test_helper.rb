require 'test/unit'

require 'rubygems'
require 'active_record'
require 'action_controller'
require 'action_view/test_case'

$:.unshift File.join(File.dirname(__FILE__), '..', 'lib')

require File.join(File.dirname(__FILE__), '..', 'init')

class Job < ActiveRecord::Base
  elapsed_time :estimate
  validates_elapsed_time_of :estimate, :allow_nil => true
end

ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :database => ":memory:")

class ActiveSupport::TestCase
  def setup_db
    stdout = $stdout

    ActiveRecord::Base.logger

    # AR keeps printing annoying schema statements
    $stdout = StringIO.new

    ActiveRecord::Schema.define(:version => 1) do
      create_table :jobs do |t|
        t.integer :estimate
      end
    end
  ensure
    $stdout = stdout
  end

  def teardown_db
    ActiveRecord::Base.connection.tables.each do |table|
      ActiveRecord::Base.connection.drop_table(table)
    end
  end
end