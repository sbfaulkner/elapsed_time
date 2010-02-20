require 'test_helper'

class Job < ActiveRecord::Base
  elapsed_time :estimate
  validates_elapsed_time_of :estimate, :allow_nil => true
end

class ValidationsTest < ActiveSupport::TestCase
  def setup
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

  def teardown
    ActiveRecord::Base.connection.tables.each do |table|
      ActiveRecord::Base.connection.drop_table(table)
    end
  end

  def test_elapsed_time
    job = Job.new(:estimate => 12345)
    assert job.save, job.errors.full_messages.to_sentence
    assert_equal 12345, job.estimate
  end

  def test_nil_elapsed_time
    job = Job.new
    assert job.save, job.errors.full_messages.to_sentence
    assert_nil job.estimate
  end

  def test_parsed_time
    job = Job.new(:estimate => '1 hour, 23 minutes and 45 seconds')
    assert job.save, job.errors.full_messages.to_sentence
    assert_equal 5025, job.estimate
  end

  def test_bad_time
    job = Job.new(:estimate => '4 eons')
    assert !job.save, 'saved with invalid elapsed time text'
    assert_equal 'is not an elapsed time', job.errors.on(:estimate)
  end
end
