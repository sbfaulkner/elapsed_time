require 'test_helper'

class ValidationsTest < ActiveSupport::TestCase
  def setup
    setup_db
  end

  def teardown
    teardown_db
  end

  def test_elapsed_time
    job = Job.new(:actual_seconds => 12345)
    assert job.save, job.errors.full_messages.to_sentence
    assert_equal 12345, job.actual_seconds
  end

  def test_nil_elapsed_time
    job = Job.new
    assert job.save, job.errors.full_messages.to_sentence
    assert_nil job.actual_seconds
  end

  def test_parsed_time
    job = Job.new(:actual_seconds => '1 hour, 23 minutes and 45 seconds')
    assert job.save, job.errors.full_messages.to_sentence
    assert_equal 5025, job.actual_seconds
  end

  def test_bad_time
    job = Job.new(:actual_seconds => '4 eons')
    assert !job.save, 'saved with invalid elapsed time text'
    assert_equal 'is not an elapsed time', job.errors.on(:actual_seconds)
  end

  def test_elapsed_minutes
    job = Job.new(:estimated_minutes => 1234)
    assert job.save, job.errors.full_messages.to_sentence
    assert_equal 1234, job.estimated_minutes
  end

  def test_parsed_minutes
    job = Job.new(:estimated_minutes => '1 hour, 23 minutes')
    assert job.save, job.errors.full_messages.to_sentence
    assert_equal 83, job.estimated_minutes
  end

  def test_elapsed_time_less_than
    job = Job.new(:estimated_minutes => 14399)
    assert job.save, job.errors.full_messages.to_sentence
  end

  def test_elapsed_time_not_less_than
    job = Job.new(:estimated_minutes => 14400)
    assert !job.save, 'saved with invalid value'
    assert_equal 'must be less than 14400 minutes', job.errors.on(:estimated_minutes)
  end

  def test_elapsed_time_greater_than
    job = Job.new(:estimated_minutes => 16)
    assert job.save, job.errors.full_messages.to_sentence
  end

  def test_elapsed_time_not_greater_than
    job = Job.new(:estimated_minutes => 15)
    assert !job.save, 'saved with invalid value'
    assert_equal 'must be more than 15 minutes', job.errors.on(:estimated_minutes)
  end

  def test_elapsed_time_less_than_or_equal_to
    job = Job.new(:actual_seconds => 14400)
    assert job.save, job.errors.full_messages.to_sentence
  end

  def test_elapsed_time_not_less_than_or_equal_to
    job = Job.new(:actual_seconds => 14401)
    assert !job.save, 'saved with invalid value'
    assert_equal 'must be no more than 14400 minutes', job.errors.on(:actual_seconds)
  end

  def test_elapsed_time_greater_than_or_equal_to
    job = Job.new(:actual_seconds => 15)
    assert job.save, job.errors.full_messages.to_sentence
  end

  def test_elapsed_time_not_greater_than_or_equal_to
    job = Job.new(:actual_seconds => 14)
    assert !job.save, 'saved with invalid value'
    assert_equal 'must be at least 15 minutes', job.errors.on(:actual_seconds)
  end
end
