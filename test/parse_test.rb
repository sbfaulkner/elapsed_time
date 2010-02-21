require 'test_helper'

class ParseTest < ActiveSupport::TestCase
  def test_parse_elapsed_time
    assert_equal 123456, '1 day, 10 hours, 17 minutes and 36 seconds'.parse_elapsed_time
  end

  def test_parse_elapsed_seconds
    assert_equal 12345, '3 hours, 25 minutes and 45 seconds'.parse_elapsed_seconds
  end

  def test_parse_elapsed_seconds_from_fractional_minutes
    assert_equal 30, '0.5 minutes'.parse_elapsed_seconds
  end

  def test_parse_elapsed_seconds_from_fractional_minutes_without_leading_zero
    assert_equal 30, '.5 minutes'.parse_elapsed_seconds
  end

  def test_parse_elapsed_minutes
    assert_equal 12345, '8 days, 13 hours and 45 minutes'.parse_elapsed_minutes
  end

  def test_parse_elapsed_minutes_with_8_hour_days
    assert_equal 4665, '8 days, 13 hours and 45 minutes'.parse_elapsed_minutes(:hours_per_day => 8)
  end

  def test_parse_elapsed_minutes_round_down
    assert_equal 2057, '1 day, 10 hours, 17 minutes and 29 seconds'.parse_elapsed_minutes
  end

  def test_parse_elapsed_minutes_round_up
    assert_equal 2058, '1 day, 10 hours, 17 minutes and 36 seconds'.parse_elapsed_minutes
  end

  def test_parse_elapsed_minutes_from_fractional_hours
    assert_equal 45, '0.75 hours'.parse_elapsed_minutes
  end

  def test_parse_elapsed_hours
    assert_equal 123, '5 days and 3 hours'.parse_elapsed_hours
  end

  def test_parse_elapsed_hours_with_8_hour_days
    assert_equal 43, '5 days and 3 hours'.parse_elapsed_hours(:hours_per_day => 8)
  end

  def test_parse_elapsed_hours_round_down
    assert_equal 34, '1 day, 10 hours, 17 minutes and 36 seconds'.parse_elapsed_hours
  end

  def test_parse_elapsed_hours_round_up
    assert_equal 35, '1 day, 10 hours, 30 minutes and 36 seconds'.parse_elapsed_hours
  end

  def test_parse_elapsed_hours_from_fractional_days
    assert_equal 6, '0.25 days'.parse_elapsed_hours
  end

  def test_parse_elapsed_hours_from_fractional_8_hour_days
    assert_equal 2, '0.25 days'.parse_elapsed_hours(:hours_per_day => 8)
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

  def test_parse_unknown_unit
    assert_raises ArgumentError do
      '1 eon'.parse_elapsed_time
    end
  end

  def test_parse_bad_format
    assert_raises ArgumentError do
      '1 !'.parse_elapsed_time
    end
  end

  def test_parse_bad_unit
    assert_raises ArgumentError do
      assert_equal 123456, '1 day, 10 hours, 17 minutes and 36 seconds'.parse_elapsed_time(:unit => :quark)
    end
  end

  def test_parse_elapsed_time_without_unit
    assert_equal 1, '1'.parse_elapsed_time
  end

  def test_parse_elapsed_seconds_without_unit
    assert_equal 3, '3'.parse_elapsed_seconds
  end

  def test_parse_elapsed_minutes_without_unit
    assert_equal 8, '8'.parse_elapsed_minutes
  end

  def test_parse_elapsed_hours_without_unit
    assert_equal 5, '5'.parse_elapsed_hours
  end

  def test_parse_elapsed_days_without_unit
    assert_equal 12, '12'.parse_elapsed_days
  end

  def test_parse_elapsed_time_from_numeric
    assert_equal 12, 12.parse_elapsed_time
  end

  def test_parse_elapsed_seconds_from_numeric
    assert_equal 12, 12.parse_elapsed_seconds
  end

  def test_parse_elapsed_minutes_from_numeric
    assert_equal 12, 12.parse_elapsed_minutes
  end

  def test_parse_elapsed_hours_from_numeric
    assert_equal 12, 12.parse_elapsed_hours
  end

  def test_parse_elapsed_days_from_numeric
    assert_equal 12, 12.parse_elapsed_days
  end

  def test_parse_elapsed_time_from_nil
    assert_nil nil.parse_elapsed_time
  end

  def test_parse_elapsed_seconds_from_nil
    assert_nil nil.parse_elapsed_seconds
  end

  def test_parse_elapsed_minutes_from_nil
    assert_nil nil.parse_elapsed_minutes
  end

  def test_parse_elapsed_hours_from_nil
    assert_nil nil.parse_elapsed_hours
  end

  def test_parse_elapsed_days_from_nil
    assert_nil nil.parse_elapsed_days
  end
end
