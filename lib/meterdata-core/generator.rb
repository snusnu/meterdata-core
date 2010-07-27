require 'meterdata-core/utils'
require 'meterdata-core/exception'

module Meterdata

  class UnsupportedGenerator < Meterdata::Exception
  end

  class Generator

    module ClassMethods # TODO use idiomatic ruby once solid and heckled

      def run(name, options)
        instantiate(name, options).run
      end

      def instantiate(name, options)
        Object.full_const_get(name).new(options)
      rescue NameError
        raise UnsupportedGenerator, "The '#{name}' generator could not be found"
      end

    end

    extend ClassMethods

    attr_reader :options

    def run
      _emit
      _analyze
      _generate
      self
    end

  private

    def initialize(options)
      @options = options
    end

    attr_accessor :raw_output
    attr_accessor :analyzed_output
    attr_accessor :report

    def _emit
      before_emit
      self.raw_output = emit
      after_emit
      self
    end

    def _analyze
      before_analyze
      self.analyzed_output = analyze
      after_analyze
      self
    end

    def _generate
      before_generate
      self.report = generate
      after_generate
      self
    end

    def before_emit()     end
    def after_emit()      end

    def before_analyze()  end
    def after_analyze()   end

    def before_generate() end
    def after_generate()  end

  end # class Generator

end # module Meterdata
