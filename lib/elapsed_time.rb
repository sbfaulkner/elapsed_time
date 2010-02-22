require 'elapsed_time/string'
require 'elapsed_time/numeric'
require 'elapsed_time/nil'
require 'elapsed_time/parse'
require 'elapsed_time/validations'
require 'elapsed_time/helpers'

I18n.load_path << "#{File.dirname(__FILE__)}/elapsed_time/locale/en.yml"

module ActiveRecord
  module ElapsedTime
    module ClassMethods
      def elapsed_time(*attr_names)
        options = attr_names.last.is_a?(Hash) ? attr_names.pop : {}
        unit = options[:unit] || 'seconds'
        attr_names.each do |attr_name|
          method_name = "parse_#{attr_name}_elapsed_#{unit}"
          class_eval <<-METHOD, __FILE__, (__LINE__+1)
            def #{method_name}
              self.#{attr_name} = #{attr_name}_before_type_cast.parse_elapsed_#{unit} unless #{attr_name}_before_type_cast.nil?
            end
            protected :#{method_name}
          METHOD
          before_save method_name.to_sym
        end
      end
    end
  end
end

ActiveRecord::Base.send :extend, ActiveRecord::ElapsedTime::ClassMethods
