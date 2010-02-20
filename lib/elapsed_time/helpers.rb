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

  module DateTimeSelectorMethods
    def self.included(base)
      base.class_eval <<-CLASS, __FILE__, __LINE__+1
        alias_method_chain :select_time, :elapsed_time
        alias_method_chain :build_options_and_select, :elapsed_time
        alias_method_chain :hour, :elapsed_time
        alias_method_chain :min, :elapsed_time
        alias_method_chain :sec, :elapsed_time
        alias_method_chain :prompt_option_tag, :elapsed_time
      CLASS
    end

    def select_time_with_elapsed_time
      @options[:ignore_date]      = true if @options[:elapsed_time]
      select_time_without_elapsed_time
    end

    def build_options_and_select_with_elapsed_time(type, selected, options = {})
      if @options[:elapsed_time]
        @options[:ignore_date] = true
        options = options.merge(:end => 99, :leading_zeros => false) if type == :hour
      end
      build_options_and_select_without_elapsed_time(type, selected, options)
    end

  private
    def hour_with_elapsed_time
      if @options[:elapsed_time]
        @datetime / 3600
      else
        hour_without_elapsed_time
      end
    end
    
    def min_with_elapsed_time
      if @options[:elapsed_time]
        (@datetime / 60) % 60
      else
        min_without_elapsed_time
      end
    end
    
    def sec_with_elapsed_time
      if @options[:elapsed_time]
        @datetime % 60
      else
        sec_without_elapsed_time
      end
    end

    def prompt_option_tag_with_elapsed_time(type, options)
      if @options[:elapsed_time] && options == true
        prompt = I18n.translate(('datetime.prompts.' + type.to_s.pluralize).to_sym, :locale => @options[:locale])
        prompt ? content_tag(:option, prompt, :value => '') : ''
      else
        prompt_option_tag_without_elapsed_time(type, options)
      end
    end
  end
end

ActionController::Base.send :helper, ElapsedTime::Helpers
ActionView::Helpers::DateTimeSelector.send :include, ElapsedTime::DateTimeSelectorMethods
