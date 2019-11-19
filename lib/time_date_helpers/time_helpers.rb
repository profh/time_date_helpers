module TimeDateHelpers
  module TimeHelpers
    def round_minutes(time, opt={})
      # Set the default options
      options = {:direction => :up, :increment => 15}
      # Merge whatever options the user has selected with the defaults
      options.merge!(opt)

      # make sure that increment is a Integer between 1 and 59
      return nil unless options[:increment].class == Integer
      return nil if (options[:increment] > 59 || options[:increment] < 1)

      # Set up some local variables used in calculations
      new_min, hr_adj = time.min, 0
      total_segments = (60.0/options[:increment]).ceil # Need to round up
      closest_segment_down = (new_min/options[:increment])
      closest_segment_up = (new_min/options[:increment]) + 1

      # Now it is time to actually adjust the minutes (and perhaps hour)
      if (new_min - options[:increment]*closest_segment_down) == 0
        new_min  # we are on an increment, so just return the minutes
      elsif options[:direction] == :up
        # if rounding up, need to check if up against the end-of-the-hour limit
        if closest_segment_up == total_segments
          new_min = 00; hr_adj=1 # near end of hour, so move up to next hour
        else
          new_min = options[:increment]*(closest_segment_up)
        end
      else
        # we are rounding down, which is very easy
        new_min = options[:increment]*(closest_segment_down)
      end

      # Finally, return the adjusted time
      Time.new(time.year, time.month, time.day, (time.hour+hr_adj), new_min, 0)
    end
    
    def round_hours(start_time, end_time, opt={})
      # Set the default options
      options = {:direction => :up, :increment => 15}
      # Merge whatever options the user has selected with the defaults
      options.merge!(opt)

      # make sure that increment is a Integer between 1 and 59
      return nil unless options[:increment].class == Integer
      return nil if (options[:increment] > 59 || options[:increment] < 1)

      # Set up some local variables used in calculations
      new_start_min, new_end_min, hr_adj = start_time.min, end_time.min, 0
      total_segments = (60.0/options[:increment]).ceil # Need to round up
      closest_segment_down = (new_min/options[:increment])
      closest_segment_up = (new_min/options[:increment]) + 1

      # Now it is time to actually adjust the minutes (and perhaps hour)
      if (new_min - options[:increment]*closest_segment_down) == 0
        new_min  # we are on an increment, so just return the minutes
      elsif options[:direction] == :up
        # if rounding up, need to check if up against the end-of-the-hour limit
        if closest_segment_up == total_segments
          new_min = 00; hr_adj=1 # near end of hour, so move up to next hour
        else
          new_min = options[:increment]*(closest_segment_up)
        end
      else
        # we are rounding down, which is very easy
        new_min = options[:increment]*(closest_segment_down)
      end

      # Finally, return the adjusted time
      Time.new(time.year, time.month, time.day, (time.hour+hr_adj), new_min, 0)
    end
    
    def humanize_time(time, opt={})
      # Set the default options
      options = {:ampm => true, :with_seconds => false}
      # Merge whatever options the user has selected with the defaults
      options.merge!(opt)
      # Make sure what is passed is legit
      return nil if time.nil? 
      return nil unless time.class == Time
      if options[:ampm]
        options[:with_seconds] ? time.strftime("%I:%M:%S %P") : time.strftime("%I:%M %P")
      else
        options[:with_seconds] ? time.strftime("%H:%M:%S") : time.strftime("%H:%M")
      end
    end
  end
end

# Add to the Object model so can call directly in main
Object.send :include, TimeDateHelpers::TimeHelpers