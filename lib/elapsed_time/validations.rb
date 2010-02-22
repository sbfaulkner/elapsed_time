module ElapsedTime
  module Validations
    RANGE_OPTIONS = { :greater_than => '>', :greater_than_or_equal_to => '>=', :less_than => '<', :less_than_or_equal_to => '<=' }
    # Validates that the value of the specified attribute is a valid elapsed time representation.
    #
    #    class Task < ActiveRecord::Base
    #      validates_elapsed_time_of :estimate, :message => "estimated time to complete does not appear to be valid"
    #      validates_elasped_time_of :work, allow_nil => true
    #    end
    #
    # Configuration options:
    # * <tt>message</tt> - A custom error message (default is: "is not an elapsed time")
    # * <tt>allow_nil</tt> - If set to true, skips this validation if the attribute is null (default is: false)
    # * <tt>allow_blank</tt> - If set to true, skips this validation if the attribute is blank (default is: false)
    # * <tt>on</tt> Specifies when this validation is active (default is :save, other options :create, :update)
    # * <tt>if</tt> - Specifies a method, proc or string to call to determine if the validation should
    #   occur (e.g. :if => :allow_validation, or :if => Proc.new { |user| user.signup_step > 2 }).  The
    #   method, proc or string should return or evaluate to a true or false value.
    # * <tt>unless</tt> - Specifies a method, proc or string to call to determine if the validation should
    #   not occur (e.g. :unless => :skip_validation, or :unless => Proc.new { |user| user.signup_step <= 2 }).  The
    #   method, proc or string should return or evaluate to a true or false value.
    def validates_elapsed_time_of(*attr_names)
      configuration = { :on => :save, :allow_nil => false, :unit => :seconds }
      configuration.update(attr_names.extract_options!)

      validates_each(attr_names, configuration) do |record, attr_name, value|
        raw_value = record.send("#{attr_name}_before_type_cast") || value

        next if configuration[:allow_nil] && raw_value.nil? || configuration[:allow_blank?] && raw_value.blank?

        begin
          parsed_value = raw_value.to_s.send("parse_elapsed_#{configuration[:unit]}")
          unit = configuration[:unit].to_s.singularize
          RANGE_OPTIONS.each do |o,m|
            next unless configuration[o]
            next if parsed_value.send(m,configuration[o])
            record.errors.add(attr_name, I18n.translate(o, :scope => 'activerecord.errors.messages.elapsed_time', :count => I18n.translate(unit, :scope => 'datetime.units', :count => configuration[o])))
          end
        rescue ArgumentError
          record.errors.add(attr_name, configuration[:message] || 'is not an elapsed time')
          next
        end
      end
    end
  end
end

ActiveRecord::Base.extend ElapsedTime::Validations
