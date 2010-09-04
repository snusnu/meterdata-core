require 'meterdata/utils'
require 'meterdata/component'
require 'meterdata/exception'
require 'meterdata/configuration'

module Meterdata

  class Generator

    class UnsupportedGenerator < Meterdata::Exception
    end

    class Report

      attr_reader :config
      attr_reader :result
      attr_reader :errors

      def initialize(config, result, errors)
        @config, @result, @errors = config, result, errors
      end

    end

    include Component

    module ClassMethods # TODO use idiomatic ruby once solid and heckled

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

    end # module ClassMethods

    extend ClassMethods

    attr_reader :config

    def run
      before_generate
      result = generate
      report = Report.new(config, result, errors)
      after_generate
      report
    end

    def generate
      raise NotImplementedError, "#{self.class}#generate must be implemented"
    end

  private

    def initialize(config)
      @config = config
    end

    def before_generate; end
    def after_generate;  end

  end # class Generator

end # module Meterdata
