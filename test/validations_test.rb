require 'test_helper'

class ValidationsTest < ActiveSupport::TestCase
  def setup
    setup_db
  end

  def teardown
    teardown_db
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
