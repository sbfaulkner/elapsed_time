require 'test_helper'

class ElapsedTimeTest < Test::Unit::TestCase
  def test_parse_elapsed_time
    assert_equal 123456, '1 day, 10 hours, 17 minutes and 36 seconds'.parse_elapsed_time
  end

  def test_parse_elapsed_seconds
    assert_equal 12345, '3 hours, 25 minutes and 45 seconds'.parse_elapsed_seconds
  end

  def test_parse_elapsed_minutes
    assert_equal 12345, '8 days, 13 hours and 45 minutes'.parse_elapsed_minutes
  end

  def test_parse_elapsed_minutes_round_down
    assert_equal 2057, '1 day, 10 hours, 17 minutes and 29 seconds'.parse_elapsed_minutes
  end

  def test_parse_elapsed_minutes_round_up
    assert_equal 2058, '1 day, 10 hours, 17 minutes and 36 seconds'.parse_elapsed_minutes
  end

  def test_parse_elapsed_hours
    assert_equal 123, '5 days and 3 hours'.parse_elapsed_hours
  end

  def test_parse_elapsed_hours_round_down
    assert_equal 34, '1 day, 10 hours, 17 minutes and 36 seconds'.parse_elapsed_hours
  end

  def test_parse_elapsed_hours_round_up
    assert_equal 35, '1 day, 10 hours, 30 minutes and 36 seconds'.parse_elapsed_hours
  end

  def test_parse_elapsed_days
    assert_equal 12, '12 days'.parse_elapsed_days
  end

  def test_parse_elapsed_days_round_down
    assert_equal 1, '1 day, 10 hours, 17 minutes and 36 seconds'.parse_elapsed_days
  end

  def test_parse_elapsed_days_round_up
    assert_equal 2, '1 day, 12 hours, 17 minutes and 36 seconds'.parse_elapsed_days
  end

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
end
