module ElapsedTime
  module NumericMethods
    # Converts a numeric value representing a number of seconds to a string describing an elapsed time.
    #
    #    1234.to_elapsed_time
    #    => "20 minutes and 34 seconds"
    #    123456.to_elapsed_time
    #    => "1 day, 10 hours, 17 minutes and 36 seconds"
    def to_elapsed_time
      minutes,seconds = self.divmod(60)
      hours,minutes = minutes.divmod(60)
      days,hours = hours.divmod(24)
      [ days.enumerate('day'), hours.enumerate('hour'), minutes.enumerate('minute'), seconds.enumerate('second') ].compact.to_sentence :skip_last_comma => true
    end
    
    def enumerate(singular)
      "#{self} #{self == 1 ? singular : singular.pluralize}" if self > 0
    end
  end
end

Integer.send :include, ElapsedTime::NumericMethods
