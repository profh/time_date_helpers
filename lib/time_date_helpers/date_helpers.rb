module TimeDateHelpers
  module DateHelpers
    # convert a date to human format of mm/dd/yyyy
    def humanize_date(date, opt={})
      # Set the default options
      options = {:style => :calendar}
      # Merge whatever options the user has selected with the defaults
      options.merge!(opt)
      # Make sure what is passed is legit
      return nil if date.nil? 
      return nil unless date.class == Date || date.class == Time || date.class == DateTime
      if options[:style] == :calendar
        date.strftime("%m/%d/%Y")
      elsif options[:style] == :full
        date.day < 10 ? date.strftime("%B%e, %Y") : date.strftime("%B %e, %Y")
      else 
        nil
      end
    end

    # convert a string to a date (using Chronic, of course)
    def convert_to_date(string)
      return nil if (string.nil? || string.class != String)
      tmp = Chronic.parse(string)
      tmp ? tmp.to_date : nil
    end

    # convert a string to a datetime (Chronic's default)
    def convert_to_datetime(string)
      return nil if (string.nil? || string.class != String)
      Chronic.parse(string)
    end
  end
end

# Add methods to Object so can be called directly in main
Object.send :include, TimeDateHelpers::DateHelpers