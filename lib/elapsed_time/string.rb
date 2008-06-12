module ElapsedTime
  module StringMethods
    # Parses a string describing an elapsed time and returns the total number of seconds.
    #
    #    "1 hour".parse_elapsed_time
    #    => 3600
    #    "1 day, 10 hours, 17 minutes and 36 seconds".parse_elapsed_time
    #    => 123456
    def parse_elapsed_time
      scanner = StringScanner.new self.strip.downcase.gsub(/(\s+and\s+|\s*,\s*)/, ' ')
  
      elapsed_time = nil
  
      while scanner.scan /([0-9]+(\.[0-9]*)?)\s*/
        duration = scanner[1].to_f

        if scanner.scan(/([a-z]+)\s*/)
          case unit = scanner[1]
          when /\Ad(ay(s)?)?\Z/
            duration = duration.days.to_i
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
          duration = duration.to_i
        end

        elapsed_time = (elapsed_time || 0) + duration
      end

      elapsed_time || raise(ArgumentError, "unrecognized format for elapsed time")
    end
  end
end

String.send :include, ElapsedTime::StringMethods
