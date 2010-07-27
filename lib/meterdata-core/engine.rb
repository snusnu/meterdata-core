require 'meterdata-core/configuration'
require 'meterdata-core/generator'

module Meterdata

  class Engine

    module ClassMethods # TODO use idiomatic ruby once solid and heckled

      def run(configuration)
        new(configuration).run
      end

    end # module ClassMethods

    extend ClassMethods


    attr_reader :configuration

    def run
      configuration.generators.each { |generator| run_generator(generator) }
      publish
      self
    end

    def published?
      @published
    end

  private

    def initialize(configuration)
      @configuration, @published = configuration, false
    end

    def publish
      @published = true
    end

    def run_generator(generator)
      require generator.require_path
      Generator.run(generator.name, generator.options)
    rescue LoadError => e
      error_msg = "The '#{generator.name}' generator could not be found at '#{generator.require_path}'"
      raise e, error_msg
    rescue UnsupportedGenerator => e
      error_msg = "'#{generator.require_path}' does not define the '#{generator.name}' generator"
      raise e, error_msg
    end

  end # class Engine

end # module Meterdata
