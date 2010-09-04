require 'meterdata/utils'
require 'meterdata/exception'

module Meterdata
  module Component

    class NotFound < Meterdata::Exception
    end

    class Loader

      def generate(config)
        new(config).run
      end

      def new(config)
        klass = component_class(config.name)
        if klass == self
          super
        else
          klass.new(config)
        end
      end

    private

      def component_not_found(name)
        raise UnsupportedGenerator, error_msg(name)
      end

    end

    def self.included(host)
      host.class_eval do
        extend ClassMethods
        include InstanceMethods
      end
    end

    module ClassMethods

      def self.extended(host)
        host.class_eval <<-RUBY
          def #{Utils.demodulize(host.name)}.component_root
            #{host}
          end
        RUBY
      end

      def load
        require require_path
        true
      rescue LoadError => e
        @report.log(:error, name, "The '#{name}' generator could not be found at '#{require_path}'")
      end

      def component_class(name)
        component_root.const_get(name)
      rescue NameError
        component_not_found(name)
      end

      def component_not_found(name)
        raise NotFound
      end

      def error_msg(name)
        "The '#{name}' #{component_name} could not be found in the #{component_root} class"
      end

      def component_name
        Utils.demodulize(component_root.name).downcase
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
