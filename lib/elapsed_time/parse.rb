module ElapsedTime
  module DefaultParseMethods
    def parse_elapsed_time(options = {})
      self
    end
    alias_method :parse_elapsed_seconds, :parse_elapsed_time
    alias_method :parse_elapsed_minutes, :parse_elapsed_time
    alias_method :parse_elapsed_hours, :parse_elapsed_time
    alias_method :parse_elapsed_days, :parse_elapsed_time
  end
end

Integer.send :include, ElapsedTime::DefaultParseMethods
NilClass.send :include, ElapsedTime::DefaultParseMethods
