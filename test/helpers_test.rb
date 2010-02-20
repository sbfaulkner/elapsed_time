require 'test_helper'

class HelpersTest < ActionView::TestCase
  tests ElapsedTime::Helpers

  def setup
    setup_db
  end

  def teardown
    teardown_db
  end

  def test_elapsed_time
    assert_equal 'about 3 hours', elapsed_time(12345)
  end

  def test_exact_elapsed_time
    assert_equal '3 hours, 25 minutes and 45 seconds', elapsed_time(12345, false)
  end

  def test_elapsed_time_select
    @job = Job.new(:estimate => 12345)

    expected = %(<select id="job_estimate_4i" name="job[estimate(4i)]">\n)
    0.upto(99) { |i| expected << %(<option value="#{sprintf("%d", i)}"#{' selected="selected"' if i == 3}>#{sprintf("%d", i)}</option>\n) }
    expected << "</select>\n"
    expected << " : "
    expected << %(<select id="job_estimate_5i" name="job[estimate(5i)]">\n)
    0.upto(59) { |i| expected << %(<option value="#{sprintf("%02d", i)}"#{' selected="selected"' if i == 25}>#{sprintf("%02d", i)}</option>\n) }
    expected << "</select>\n"

    assert_dom_equal expected, time_select(:job, :estimate, :elapsed_time => true)
  end

  def test_elapsed_time_select_with_seconds
    @job = Job.new(:estimate => 12345)

    expected = %(<select id="job_estimate_4i" name="job[estimate(4i)]">\n)
    0.upto(99) { |i| expected << %(<option value="#{sprintf("%d", i)}"#{' selected="selected"' if i == 3}>#{sprintf("%d", i)}</option>\n) }
    expected << "</select>\n"
    expected << " : "
    expected << %(<select id="job_estimate_5i" name="job[estimate(5i)]">\n)
    0.upto(59) { |i| expected << %(<option value="#{sprintf("%02d", i)}"#{' selected="selected"' if i == 25}>#{sprintf("%02d", i)}</option>\n) }
    expected << "</select>\n"
    expected << " : "
    expected << %(<select id="job_estimate_6i" name="job[estimate(6i)]">\n)
    0.upto(59) { |i| expected << %(<option value="#{sprintf("%02d", i)}"#{' selected="selected"' if i == 45}>#{sprintf("%02d", i)}</option>\n) }
    expected << "</select>\n"

    assert_dom_equal expected, time_select(:job, :estimate, :elapsed_time => true, :include_seconds => true)
  end

  def test_elapsed_time_select_with_html_options
    @job = Job.new(:estimate => 12345)

    expected = %(<select id="job_estimate_4i" name="job[estimate(4i)]" class="selector">\n)
    0.upto(99) { |i| expected << %(<option value="#{sprintf("%d", i)}"#{' selected="selected"' if i == 3}>#{sprintf("%d", i)}</option>\n) }
    expected << "</select>\n"
    expected << " : "
    expected << %(<select id="job_estimate_5i" name="job[estimate(5i)]" class="selector">\n)
    0.upto(59) { |i| expected << %(<option value="#{sprintf("%02d", i)}"#{' selected="selected"' if i == 25}>#{sprintf("%02d", i)}</option>\n) }
    expected << "</select>\n"

    assert_dom_equal expected, time_select(:job, :estimate, {:elapsed_time => true}, :class => 'selector')
  end

  def test_elapsed_time_select_with_separator
    @job = Job.new(:estimate => 12345)

    expected = %(<select id="job_estimate_4i" name="job[estimate(4i)]">\n)
    0.upto(99) { |i| expected << %(<option value="#{sprintf("%d", i)}"#{' selected="selected"' if i == 3}>#{sprintf("%d", i)}</option>\n) }
    expected << "</select>\n"
    expected << %(<span class="time-separator">:</span>)
    expected << %(<select id="job_estimate_5i" name="job[estimate(5i)]">\n)
    0.upto(59) { |i| expected << %(<option value="#{sprintf("%02d", i)}"#{' selected="selected"' if i == 25}>#{sprintf("%02d", i)}</option>\n) }
    expected << "</select>\n"

    assert_dom_equal expected, time_select(:job, :estimate, :elapsed_time => true, :time_separator => '<span class="time-separator">:</span>')
  end

  def test_elapsed_time_select_with_default_prompt
    @job = Job.new(:estimate => 12345)

    expected = %(<select id="job_estimate_4i" name="job[estimate(4i)]">\n)
    expected << %(<option value=\"\">Hours</option>)
    0.upto(99) { |i| expected << %(<option value="#{sprintf("%d", i)}"#{' selected="selected"' if i == 3}>#{sprintf("%d", i)}</option>\n) }
    expected << "</select>\n"
    expected << " : "
    expected << %(<select id="job_estimate_5i" name="job[estimate(5i)]">\n)
    expected << %(<option value=\"\">Minutes</option>)
    0.upto(59) { |i| expected << %(<option value="#{sprintf("%02d", i)}"#{' selected="selected"' if i == 25}>#{sprintf("%02d", i)}</option>\n) }
    expected << "</select>\n"

    assert_dom_equal expected, time_select(:job, :estimate, :elapsed_time => true, :prompt => true)
  end

  def test_elapsed_time_select_with_custom_prompt
    @job = Job.new(:estimate => 12345)

    expected = %(<select id="job_estimate_4i" name="job[estimate(4i)]">\n)
    expected << %(<option value=\"\">Choose hours</option>)
    0.upto(99) { |i| expected << %(<option value="#{sprintf("%d", i)}"#{' selected="selected"' if i == 3}>#{sprintf("%d", i)}</option>\n) }
    expected << "</select>\n"
    expected << " : "
    expected << %(<select id="job_estimate_5i" name="job[estimate(5i)]">\n)
    expected << %(<option value=\"\">Choose minutes</option>)
    0.upto(59) { |i| expected << %(<option value="#{sprintf("%02d", i)}"#{' selected="selected"' if i == 25}>#{sprintf("%02d", i)}</option>\n) }
    expected << "</select>\n"

    assert_dom_equal expected, time_select(:job, :estimate, :elapsed_time => true, :prompt => {:hour => 'Choose hours', :minute => 'Choose minutes'})
  end

  def test_elapsed_time_select_should_not_change_passed_options_hash
    @job = Job.new(:estimate => 12345)

    options = {
      :default => { :hour => 23, :minute => 30, :second => 1 },
      :discard_type => false,
      :include_blank => false,
      :include_seconds => true,
      :elapsed_time => true
    }
    time_select(:job, :estimate, options)
  
    # note: the literal hash is intentional to show that the actual options hash isn't modified
    #       don't change this!
    assert_equal({
      :default => { :hour => 23, :minute => 30, :second => 1 },
      :discard_type => false,
      :include_blank => false,
      :include_seconds => true,
      :elapsed_time => true
    }, options)
  end

  def test_elapsed_time_select_within_fields_for
    job = Job.new(:estimate => 12345)

    fields_for :job, job do |f|
      concat f.time_select :estimate, :elapsed_time => true
    end

    expected = %(<select id="job_estimate_4i" name="job[estimate(4i)]">\n)
    0.upto(99) { |i| expected << %(<option value="#{sprintf("%d", i)}"#{' selected="selected"' if i == 3}>#{sprintf("%d", i)}</option>\n) }
    expected << "</select>\n"
    expected << " : "
    expected << %(<select id="job_estimate_5i" name="job[estimate(5i)]">\n)
    0.upto(59) { |i| expected << %(<option value="#{sprintf("%02d", i)}"#{' selected="selected"' if i == 25}>#{sprintf("%02d", i)}</option>\n) }
    expected << "</select>\n"

    assert_dom_equal expected, output_buffer
  end
end