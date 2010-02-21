require 'test_helper'

class NilTest < ActiveSupport::TestCase
  def test_to_elapsed_time
    assert_nil nil.to_elapsed_time
  end

  def test_to_elapsed_seconds
    assert_nil nil.to_elapsed_seconds
  end

  def test_to_elapsed_minutes
    assert_nil nil.to_elapsed_minutes
  end

  def test_to_elapsed_hours
    assert_nil nil.to_elapsed_hours
  end

  def test_to_elapsed_days
    assert_nil nil.to_elapsed_days
  end
end
