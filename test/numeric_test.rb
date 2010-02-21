require 'test_helper'

class NumericTest < ActiveSupport::TestCase
  def test_to_elapsed_time
    assert_equal '1 day, 10 hours, 17 minutes and 36 seconds', 123456.to_elapsed_time
  end

  def test_to_elapsed_seconds
    assert_equal '3 hours, 25 minutes and 45 seconds', 12345.to_elapsed_seconds
  end

  def test_to_elapsed_minutes
    assert_equal '8 days, 13 hours and 45 minutes', 12345.to_elapsed_minutes
  end

  def test_to_elapsed_hours
    assert_equal '5 days and 3 hours', 123.to_elapsed_hours
  end

  def test_to_elapsed_days
    assert_equal '12 days', 12.to_elapsed_days
  end

  def test_zero_elapsed_seconds
    assert_equal '', 0.to_elapsed_seconds
  end

  def test_zero_elapsed_minutes
    assert_equal '', 0.to_elapsed_minutes
  end

  def test_zero_elapsed_hours
    assert_equal '', 0.to_elapsed_hours
  end

  def test_zero_elapsed_days
    assert_equal '', 0.to_elapsed_days
  end
end
