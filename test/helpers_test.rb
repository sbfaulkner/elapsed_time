require 'test_helper'

class HelpersTest < ActionView::TestCase
  helper ElapsedTime::Helpers

  def test_elapsed_time
    assert_equal 'about 3 hours', elapsed_time(12345)
  end

  def test_exact_elapsed_time
    assert_equal '3 hours, 25 minutes and 45 seconds', elapsed_time(12345, false)
  end
end
