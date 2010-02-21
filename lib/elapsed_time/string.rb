module ElapsedTime
  module StringMethods
    # Parses a string describing an elapsed time and returns the total number of seconds.
    #
    #    "1 hour".parse_elapsed_time
    #    => 3600
    #    "1 day, 10 hours, 17 minutes and 36 seconds".parse_elapsed_time
    #    => 123456
    def parse_elapsed_time(options = {})
      options.symbolize_keys!

      hours_per_day = options[:hours_per_day] || 24
      unit_of_time = options[:unit] || :seconds
      raise(ArgumentError, "unit should be one of :days, :hours, :minutes or :seconds; got #{unit_of_time}") unless %w(days hours minutes seconds).include?(unit_of_time.to_s)

      scanner = StringScanner.new self.strip.downcase.gsub(/(\s+and\s+|\s*,\s*)/, ' ')

      elapsed_time = nil

      while ! scanner.scan(/([0-9]*(?:\.[0-9]*)?)\s*/).blank?
        break if scanner[1].blank?
        duration = scanner[1].to_f

        if scanner.scan(/([a-z]+)\s*/)
          case unit = scanner[1]
          when /\Ad(ay(s)?)?\Z/
            duration = (duration * hours_per_day.hours).to_i
          when /\Ah(our(s)?)?\Z/
            duration = duration.hours.to_i
          when /\Am(in(ute(s)?)?)?\Z/
            duration = duration.minutes.to_i
          when /\As(ec(ond(s)?)?)?\Z/
            duration = duration.to_i
          else
            raise ArgumentError, "'#{unit}' is not a recognized unit of time"
          end
        else
          raise(ArgumentError, "unrecognized format for elapsed time") if scanner.scan(/./)
          case unit_of_time
          when :days
            duration = (duration * hours_per_day.hours).to_i
          when :hours
            duration = duration.hours.to_i
          when :minutes
            duration = duration.minutes.to_i
          when :seconds
            duration = duration.to_i
          end
        end

        elapsed_time = (elapsed_time || 0) + duration
      end

      raise(ArgumentError, "unrecognized format for elapsed time") unless elapsed_time

      case unit_of_time.to_sym
      when :days
        elapsed_time /= hours_per_day.hours.to_f
      when :hours
        elapsed_time /= 1.hour.to_f
      when :minutes
        elapsed_time /= 1.minute.to_f
      when :seconds
        elapsed_time
      end
      elapsed_time.round
    end
    alias_method :parse_elapsed_seconds, :parse_elapsed_time

    def parse_elapsed_minutes(options = {})
      parse_elapsed_time(options.merge(:unit => :minutes))
    end

    def parse_elapsed_hours(options = {})
      parse_elapsed_time(options.merge(:unit => :hours))
    end

    def parse_elapsed_days(options = {})
      parse_elapsed_time(options.merge(:unit => :days))
    end
  end
end

String.send :include, ElapsedTime::StringMethods
