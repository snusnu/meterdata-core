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
        new(config, report).run
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

    attr_reader :config
    attr_reader :report

    def run
      before_publish
      self.published = publish
      after_publish
      self
    end

    def publish
      raise NotImplementedError, "#{self.class}#publish must be implemented"
    end

    def published?
      @published
    end

  protected

    attr_writer :published

  private

    def initialize(config, report)
      @config, @report, @published = config, report, false
    end

    def before_publish; end
    def after_publish;  end

  end

end
