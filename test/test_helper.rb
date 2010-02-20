require 'test/unit'

require 'rubygems'
require 'active_record'

module ActionController
  class Base
    def self.helper(mod)
      include mod
    end
  end
end

$:.unshift File.join(File.dirname(__FILE__), '..', 'lib')

require File.join(File.dirname(__FILE__), '..', 'init')

class Test::Unit::TestCase
  def setup_db
    stdout = $stdout

    ActiveRecord::Base.logger

    # AR keeps printing annoying schema statements
    $stdout = StringIO.new

    ActiveRecord::Schema.define(:version => 1) do
      create_table :tasks do |t|
        t.integer :estimate, :default => 0
      end

      create_table :activity do |t|
        t.column :task_id, :integer
        t.integer :duration, :null => false
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

ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :database => ":memory:")

class Job < ActiveRecord::Base
  elapsed_time :estimate
  validates_elapsed_time_of :estimate, :allow_nil => true
end
