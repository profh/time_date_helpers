require "minitest/autorun"
require 'chronic'
require 'time_date_helpers'

class DateHelperTests < Minitest::Test
  
  # Test humanize_date method
  def test_humanize_date_works
                                                          ### Great Dates in History ###
    date1 = Time.new(1776, 07, 04, 0, 0, 0)               # Declaration of Independence signed
    date2 = Date.new(1929, 01, 15)                        # Martin Luther King, Jr. born
    date3 = DateTime.new(1986, 10, 04, 0, 0, 0)           # Day I married my sweetheart
    date4 = Time.new(2012, 12, 25, 0, 0, 0)               # Christmas (celebrating the incarnation of Jesus)
    assert_equal '07/04/1776', humanize_date(date1)
    assert_equal '01/15/1929', humanize_date(date2)
    assert_equal '10/04/1986', humanize_date(date3)
    assert_equal '12/25/2012', humanize_date(date4)
  end
  
  def test_humanize_date_works_with_option
    date1 = Time.new(1776, 07, 04, 0, 0, 0)
    date2 = Date.new(1929, 01, 15)
    date3 = DateTime.new(1986, 10, 04, 0, 0, 0)
    date4 = Time.new(2012, 12, 25, 0, 0, 0)
    assert_equal 'July 4, 1776', humanize_date(date1, :style => :full)
    assert_equal 'January 15, 1929', humanize_date(date2, :style => :full)
    assert_equal 'October 4, 1986', humanize_date(date3, :style => :full)
    assert_equal 'December 25, 2012', humanize_date(date4, :style => :full)
  end
  
  def test_humanize_date_fails_for_nondates
    date1 = nil
    date2 = "10/04/1986"
    date3 = 3.14159
    assert_nil humanize_date(date1)
    assert_nil humanize_date(date2)
    assert_nil humanize_date(date3)
  end
  
  # Test convert_to_date
  def test_convert_to_date_works
    date1 = "10/04/1986"
    date2 = "tomorrow"
    date3 = "yesterday at 3pm"
    date4 = "2012-12-25"
    date5 = "April 1, 1999"
    assert_equal 10, convert_to_date(date1).month
    assert_equal Date.today + 1, convert_to_date(date2)
    # note that the assertion below will fail right after the switch to/from DST 
    assert_equal Date.today - 1, convert_to_date(date3)
    assert_equal 25, convert_to_date(date4).day
    assert_equal 1999, convert_to_date(date5).year
    assert_nil convert_to_date(nil)
    assert_nil convert_to_date("FRED!")
    assert_nil convert_to_date(3.14159)
  end
  
  # Test test_convert_to_datetime
  def test_convert_to_datetime_works
    datetime1 = "10/04/1986"
    datetime2 = "tomorrow"
    datetime3 = "yesterday at 3pm"
    datetime4 = "2012-12-25 08:46:01"
    datetime5 = "April 1, 1999 at 10pm"
    datetime6 = "1 hour ago"
    today = Date.today
    assert_equal 10, convert_to_datetime(datetime1).month
    assert_equal Time.new((today).year, (today).month, (today+1).day, 12, 0, 0), convert_to_datetime(datetime2)
    # note that the assertion below will fail right after the switch to/from DST
    assert_equal Time.new((today).year, (today).month, (today-1).day, 15, 0, 0), convert_to_datetime(datetime3)
    assert_equal 8, convert_to_datetime(datetime4).hour
    assert_equal 22, convert_to_datetime(datetime5).hour
    assert_equal (Time.now - 3600).hour, convert_to_datetime(datetime6).hour
    assert_nil convert_to_datetime(nil)
    assert_nil convert_to_datetime("FRED!")
    assert_nil convert_to_datetime(3.14159)
  end 
end
