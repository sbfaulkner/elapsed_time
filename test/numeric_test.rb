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

  def test_to_elapsed_time_with_alternate_units
    assert_equal '1 day, 10 hr, 17 min and 36 sec', 123456.to_elapsed_time(:units => {:day => 'day', :hour => 'hr', :minute => 'min', :second => 'sec'})
  end

  def test_zero_elapsed_seconds_including_zero
    assert_equal '0 seconds', 0.to_elapsed_seconds(:include_zero => true)
  end

  def test_zero_elapsed_minutes_including_zero
    assert_equal '0 minutes', 0.to_elapsed_minutes(:include_zero => true)
  end

  def test_zero_elapsed_hours_including_zero
    assert_equal '0 hours', 0.to_elapsed_hours(:include_zero => true)
  end

  def test_zero_elapsed_days_including_zero
    assert_equal '0 days', 0.to_elapsed_days(:include_zero => true)
  end
end
