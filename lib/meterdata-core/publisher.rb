require 'meterdata-core/utils'
require 'meterdata-core/component'
require 'meterdata-core/exception'

module Meterdata

  class Publisher

    class UnsupportedPublisher < Meterdata::Exception
    end

    include Component

    module ClassMethods # TODO use idiomatic ruby once solid and heckled

      def publish(config, report)
        new(config, report).publish
      end

      def new(config, report)
        klass = component_class(config.name)
        if klass == self
          super
        else
          klass.new(config, report)
        end
      end

    private

      def component_not_found(name)
        raise UnsupportedPublisher, error_msg(name)
      end

    end # module ClassMethods

    extend ClassMethods

    include Utils

    attr_reader :config
    attr_reader :report

    def run
      before_publish
      published = publish
      after_publish
      published
    end

    def publish
      raise NotImplementedError, "#{self.class}#publish must be implemented"
    end

  private

    def initialize(config, report)
      @config, @report = config, report
    end

    def before_publish; end
    def after_publish;  end

  end

end
