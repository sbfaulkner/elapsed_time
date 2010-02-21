require 'elapsed_time/string'
require 'elapsed_time/numeric'
require 'elapsed_time/nil'
require 'elapsed_time/parse'
require 'elapsed_time/validations'
require 'elapsed_time/helpers'

module ActiveRecord
  module ElapsedTime
    module ClassMethods
      def elapsed_time(*attr_names)
        attr_names.each do |attr_name|
          method_name = "parse_#{attr_name}_elapsed_time"
          class_eval <<-METHOD, __FILE__, (__LINE__+1)
            def #{method_name}
              self.#{attr_name} = #{attr_name}_before_type_cast.parse_elapsed_time unless #{attr_name}_before_type_cast.nil?
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

I18n.load_path << "#{File.dirname(__FILE__)}/elapsed_time/locale/en.yml"
