require 'meterdata-core/exception'
require 'meterdata-core/configuration'
require 'meterdata-core/generator'
require 'meterdata-core/report'
require 'meterdata-core/publisher'

module Meterdata

  class Engine

    class Reporter

      module ClassMethods # TODO use idiomatic ruby once solid and heckled

        def collect(config, report)
          new(config, report).collect
        end

      end # module ClassMethods

      extend ClassMethods

      def collect
        @report.add(generate)
        self
      end

    private

      def initialize(config, report)
        @config, @report = config, report
      end

      def generate
        load_generator
        Meterdata::Generator.generate(@config)
      rescue Meterdata::Generator::UnsupportedGenerator => e
        @report.log(:error, name, "'#{require_path}' does not define the '#{name}' generator")
      end

      def load_generator
        require require_path
        true
      rescue LoadError => e
        @report.log(:error, name, "The '#{name}' generator could not be found at '#{require_path}'")
      end

      def name
        @config.name
      end

      def require_path
        @config.require_path
      end

      def options
        @config.options
      end

    end # class Reporter


    module ClassMethods # TODO use idiomatic ruby once solid and heckled

      def run(configuration)
        new(configuration).run
      end

    end # module ClassMethods

    extend ClassMethods


    attr_reader :config
    attr_reader :report

    def run
      collect
      publish
      self
    end

  private

    def initialize(config)
      @config = config
      @report = Report.new
    end

    def collect
      config.generators.each do |config|
        Reporter.collect(config, report)
      end
    end

    def publish
      config.publishers.each do |config|
        Publisher.publish(config, report)
      end
    end

  end # class Engine

end # module Meterdata
