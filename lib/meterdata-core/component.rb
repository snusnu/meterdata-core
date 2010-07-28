require 'meterdata-core/utils'

module Meterdata
  module Component

    def self.included(host)
      host.class_eval do
        extend ClassMethods
        include InstanceMethods
      end
    end

    module ClassMethods

      def self.extended(host)
        host.class_eval <<-RUBY
          class << self
            def component_root
              #{host}
            end
          end
        RUBY
      end

      include Utils

      def component_class(name)
        component_root.const_get(name)
      rescue NameError
        component_not_found(name)
      end

      def component_not_found(name)
        raise NotImplementedError, "Meterdata::Component.component_not_found must be implemented"
      end

      def error_msg(name)
        "The '#{name}' #{component_name} could not be found in the #{component_root} class"
      end

      def component_name
        demodulize(component_root.name).downcase
      end

    end

    module InstanceMethods

      def run
        raise NotImplementedError, "Meterdata::Component#run must be implemented"
      end

      def errors
        @errors ||= []
      end

    end

  end
end
