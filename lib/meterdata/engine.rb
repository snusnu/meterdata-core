require 'meterdata/exception'
require 'meterdata/configuration'
require 'meterdata/generator'
require 'meterdata/report'
require 'meterdata/publisher'

module Meterdata

  class Engine

    class Reporter

      def self.collect(config, report)
        new(config, report).collect
      end

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


    def self.run(configuration)
      new(configuration).run
    end

    attr_reader :config
    attr_reader :report

    def run
      collect
      transform
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

    def transform
      config.transformers.each do |config|
        Transformer.transform(config, report)
    end

    def publish
      config.publishers.each do |config|
        Publisher.publish(config, report)
      end
    end

  end # class Engine

end # module Meterdata
