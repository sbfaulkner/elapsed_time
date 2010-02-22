module ElapsedTime
  module NumericMethods
    # Converts a numeric value representing a number of seconds to a string describing an elapsed time.
    #
    #    1234.to_elapsed_seconds
    #    => "20 minutes and 34 seconds"
    #    123456.to_elapsed_seconds
    #    => "1 day, 10 hours, 17 minutes and 36 seconds"
    def to_elapsed_time(options = {})
      unit = options[:unit] || :second
      units = {:day => :day, :hour => :hour, :minute => :minute, :second => :second}
      units.merge!(options[:units]) if options[:units] 

      return options[:include_zero] ? enumerate(unit, true) : '' if zero?

      minutes,seconds = divmod(60)
      hours,minutes = minutes.divmod(60)
      days,hours = hours.divmod(24)

      [
        days.enumerate(units[:day], options[:include_zero]),
        hours.enumerate(units[:hour], options[:include_zero]),
        minutes.enumerate(units[:minute], options[:include_zero]),
        seconds.enumerate(units[:second], options[:include_zero])
      ].compact.to_sentence :last_word_connector => I18n.translate('support.array.two_words_connector')
    end
    alias_method :to_elapsed_seconds, :to_elapsed_time

    def to_elapsed_minutes(options = {})
      minutes.to_elapsed_time(options.merge(:unit => :minute))
    end

    def to_elapsed_hours(options = {})
      hours.to_elapsed_time(options.merge(:unit => :hour))
    end

    def to_elapsed_days(options = {})
      days.to_elapsed_time(options.merge(:unit => :day))
    end

    def enumerate(type, include_zero)
      return if zero? && !include_zero
      if type.is_a?(Symbol)
        I18n.translate(type, :scope => 'datetime.units', :count => self)
      else
        "#{self} #{type}"
      end
    end
  end
end

Integer.send :include, ElapsedTime::NumericMethods
