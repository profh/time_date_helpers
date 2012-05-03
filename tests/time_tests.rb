require 'test/unit'
require 'time_date_helpers'

class TimeHelperTests < Test::Unit::TestCase
  
  def test_default_settings
    quarter1 = Time.new(2012, 04, 30, 9, 6, 0)
    quarter2 = Time.new(2012, 04, 30, 9, 16, 0)
    quarter3 = Time.new(2012, 04, 30, 9, 36, 0)
    quarter4 = Time.new(2012, 04, 30, 9, 46, 0)
    assert_equal('09:15', round_minutes(quarter1).strftime('%H:%M'))
    assert_equal('09:30', round_minutes(quarter2).strftime('%H:%M'))
    assert_equal('09:45', round_minutes(quarter3).strftime('%H:%M'))
    assert_equal('10:00', round_minutes(quarter4).strftime('%H:%M'))
  end
  
  def test_even_increments
    # Test cases where total segments is an integer (i.e., 60%increment==0)
    inc = 10
    time1 = Time.new(2012, 04, 30, 9, 6, 0)
    time2 = Time.new(2012, 04, 30, 9, 16, 0)
    time3 = Time.new(2012, 04, 30, 9, 36, 0)
    time4 = Time.new(2012, 04, 30, 9, 46, 0)
    time5 = Time.new(2012, 04, 30, 9, 50, 0)
    time6 = Time.new(2012, 04, 30, 9, 56, 0)
    assert_equal('09:10', round_minutes(time1, :increment => inc).strftime('%H:%M'))
    assert_equal('09:20', round_minutes(time2, :increment => inc).strftime('%H:%M'))
    assert_equal('09:40', round_minutes(time3, :increment => inc).strftime('%H:%M'))
    assert_equal('09:50', round_minutes(time4, :increment => inc).strftime('%H:%M'))
    assert_equal('09:50', round_minutes(time5, :increment => inc).strftime('%H:%M'))
    assert_equal('10:00', round_minutes(time6, :increment => inc).strftime('%H:%M'))
  end
  
  def test_uneven_increments
    # Test cases where total segments is not an integer (i.e., 60%increment!=0)
    inc = 8
    time1 = Time.new(2012, 04, 30, 9, 6, 0)
    time2 = Time.new(2012, 04, 30, 9, 16, 0)
    time3 = Time.new(2012, 04, 30, 9, 34, 0)
    time4 = Time.new(2012, 04, 30, 9, 46, 0)
    time5 = Time.new(2012, 04, 30, 9, 56, 0)
    time6 = Time.new(2012, 04, 30, 9, 59, 0)
    assert_equal('09:08', round_minutes(time1, :increment => inc).strftime('%H:%M'))
    assert_equal('09:16', round_minutes(time2, :increment => inc).strftime('%H:%M'))
    assert_equal('09:40', round_minutes(time3, :increment => inc).strftime('%H:%M'))
    assert_equal('09:48', round_minutes(time4, :increment => inc).strftime('%H:%M'))
    assert_equal('09:56', round_minutes(time5, :increment => inc).strftime('%H:%M'))
    assert_equal('10:00', round_minutes(time6, :increment => inc).strftime('%H:%M'))
  end
  
  def test_direction_down
    quarter1 = Time.new(2012, 04, 30, 9, 6, 0)
    quarter2 = Time.new(2012, 04, 30, 9, 16, 0)
    quarter3 = Time.new(2012, 04, 30, 9, 36, 0)
    quarter4 = Time.new(2012, 04, 30, 9, 46, 0)
    assert_equal('09:00', round_minutes(quarter1, :direction => :down).strftime('%H:%M'))
    assert_equal('09:15', round_minutes(quarter2, :direction => :down).strftime('%H:%M'))
    assert_equal('09:30', round_minutes(quarter3, :direction => :down).strftime('%H:%M'))
    assert_equal('09:45', round_minutes(quarter4, :direction => :down).strftime('%H:%M'))
  end
  
  def test_increments_and_direction_together
    inc = 8
    time1 = Time.new(2012, 04, 30, 9, 6, 0)
    time2 = Time.new(2012, 04, 30, 9, 16, 0)
    time3 = Time.new(2012, 04, 30, 9, 34, 0)
    time4 = Time.new(2012, 04, 30, 9, 46, 0)
    time5 = Time.new(2012, 04, 30, 9, 56, 0)
    time6 = Time.new(2012, 04, 30, 9, 59, 0)
    assert_equal('09:00', round_minutes(time1, :increment => inc, :direction => :down).strftime('%H:%M'))
    assert_equal('09:16', round_minutes(time2, :increment => inc, :direction => :down).strftime('%H:%M'))
    assert_equal('09:32', round_minutes(time3, :increment => inc, :direction => :down).strftime('%H:%M'))
    assert_equal('09:40', round_minutes(time4, :direction => :down, :increment => inc).strftime('%H:%M'))
    assert_equal('09:56', round_minutes(time5, :direction => :down, :increment => inc).strftime('%H:%M'))
    assert_equal('09:56', round_minutes(time6, :direction => :down, :increment => inc).strftime('%H:%M'))
  end
  
  # Test humanize_time
  def test_humanize_time_works
    time1 = Time.new(2012, 01, 01, 0, 0, 0)
    time2 = Time.new(2012, 01, 01, 9, 36, 59)
    time3 = Time.new(2012, 01, 01, 11, 11, 11)
    time4 = Time.new(2012, 01, 01, 15, 14, 15)
    assert_equal '12:00 am', humanize_time(time1)
    assert_equal '09:36 am', humanize_time(time2)
    assert_equal '11:11 am', humanize_time(time3)
    assert_equal '03:14 pm', humanize_time(time4)
  end
  
  def test_humanize_time_works_with_military_time
    time1 = Time.new(2012, 01, 01, 0, 0, 0)
    time2 = Time.new(2012, 01, 01, 9, 36, 59)
    time3 = Time.new(2012, 01, 01, 11, 11, 11)
    time4 = Time.new(2012, 01, 01, 15, 14, 15)
    assert_equal '00:00', humanize_time(time1, :ampm => false)
    assert_equal '09:36', humanize_time(time2, :ampm => false)
    assert_equal '11:11', humanize_time(time3, :ampm => false)
    assert_equal '15:14', humanize_time(time4, :ampm => false)
  end
  
  def test_humanize_time_works_with_seconds_option
    time1 = Time.new(2012, 01, 01, 0, 0, 0)
    time2 = Time.new(2012, 01, 01, 9, 36, 59)
    time3 = Time.new(2012, 01, 01, 11, 11, 11)
    time4 = Time.new(2012, 01, 01, 15, 14, 15)
    assert_equal '12:00:00 am', humanize_time(time1, :with_seconds => true)
    assert_equal '09:36:59 am', humanize_time(time2, :with_seconds => true)
    assert_equal '11:11:11 am', humanize_time(time3, :with_seconds => true)
    assert_equal '03:14:15 pm', humanize_time(time4, :with_seconds => true)
  end
  
  def test_humanize_time_fails_for_nontimes
    time1 = nil
    time2 = "10/04/1986"
    time3 = 3.14159
    assert_nil humanize_time(time1)
    assert_nil humanize_time(time2)
    assert_nil humanize_time(time3)
  end
end
