module ElapsedTime
  module NilMethods
    def to_elapsed_time
    end
    alias_method :to_elapsed_seconds, :to_elapsed_time
    alias_method :to_elapsed_minutes, :to_elapsed_time
    alias_method :to_elapsed_hours, :to_elapsed_time
    alias_method :to_elapsed_days, :to_elapsed_time
  end
end

NilClass.send :include, ElapsedTime::NilMethods
