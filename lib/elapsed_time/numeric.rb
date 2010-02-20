module ElapsedTime
  module NumericMethods
    # Converts a numeric value representing a number of seconds to a string describing an elapsed time.
    #
    #    1234.to_elapsed_seconds
    #    => "20 minutes and 34 seconds"
    #    123456.to_elapsed_seconds
    #    => "1 day, 10 hours, 17 minutes and 36 seconds"
    def to_elapsed_seconds
      minutes,seconds = divmod(60)
      hours,minutes = minutes.divmod(60)
      days,hours = hours.divmod(24)
      [ days.enumerate('day'), hours.enumerate('hour'), minutes.enumerate('minute'), seconds.enumerate('second') ].compact.to_sentence :last_word_connector => I18n.translate(:'support.array.two_words_connector')
    end

    def to_elapsed_minutes
      minutes.to_elapsed_seconds
    end

    def to_elapsed_hours
      hours.to_elapsed_seconds
    end

    def to_elapsed_days
      days.to_elapsed_seconds
    end

    # alias for legacy compatability
    alias_method :to_elapsed_time, :to_elapsed_seconds

    def enumerate(singular)
      "#{self} #{self == 1 ? singular : singular.pluralize}" if self > 0
    end
  end
end

Integer.send :include, ElapsedTime::NumericMethods
