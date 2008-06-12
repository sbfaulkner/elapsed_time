module ElapsedTime
  module Helpers
    # Outputs a number of seconds as a string representing an elapsed time.
    #
    # The output string may be an exact representation or an approximation (output using the Rails-provided distance_of_time_in_words helper).
    def elapsed_time(seconds, approximation = true)
      return nil if seconds.blank?
      if approximation
        distance_of_time_in_words(0, seconds, true)
      else
        seconds.to_elapsed_time
      end
    end
  end
end

ActionController::Base.send :helper, ElapsedTime::Helpers
