require 'erb'

require 'meterdata-core/utils'
require 'meterdata-core/exception'

module Meterdata

  class Configuration

    class MissingConfigFileError < Meterdata::Exception; end
    class UnsupportedFormatError < Meterdata::Exception; end

    class Parser

      module ClassMethods # TODO use idiomatic ruby once solid and heckled

        def new(path)
          self < Parser ? super : parser_class(path).new(path)
        end

      private

        def parser_class(path)
          case path
          when /.json/
            JsonParser
          when /.yml/
            YamlParser
          else
            error_msg = "'#{path}' is not a supported file type for meterdata config files (use .yml or .json)"
            raise UnsupportedFormatError, error_msg
          end
        end

      end # module ClassMethods

      extend ClassMethods

      def parse
        Configuration.new(generators, publishers)
      end

    private

      def initialize(path)
        @path = path
      end

      def config
        @config ||= load
      end

      def load
        raise NotImplementedError, "#{self.class}#load must be implemented"
      end

      def erb_parsed_config
        ERB.new(File.read(@path)).result
      rescue Errno::ENOENT
        raise MissingConfigFileError, "No config file found at #{@path}"
      end

      def generators
        components('generators', Generator)
      end

      def publishers
        components('publishers', Publisher)
      end

      def components(name, klass)
        return [] unless config[name]
        config[name].map do |config|
          klass.new(config)
        end
      end

      class JsonParser < Parser
        private
        def load
          require 'json'
          JSON.parse(erb_parsed_config)
        end
      end

      class YamlParser < Parser
        private
        def load
          require 'yaml'
          YAML.load(erb_parsed_config)
        end
      end

    end # class Parser

    module Component

      class IncompleteError < Meterdata::Exception
      end

      include Meterdata::Utils

      def self.included(host)
        host.class_eval do
          attr_reader :version
          attr_reader :name
          attr_reader :require_path
        end
      end

      def initialize(config)
        @version      = config['version']
        @name         = config['name']
        @require_path = config['require_path']
        @options      = config['options']

        raise IncompleteError, error_message unless valid?
      end

      def options
        @options ||= {}
      end

    private

      def valid?
        missing_keys.empty?
      end

      def missing_keys
        required_keys.select { |key| send(key).nil? }
      end

      def required_keys
        %w[version name require_path]
      end

      def error_message
        "The following #{component_name} key(s) are missing: #{missing_keys.join(', ')}"
      end

      def component_name
        demodulize(self.class.name).downcase
      end

    end

    class Generator
      include Component
    end

    class Publisher
      include Component
    end


    module ClassMethods # TODO use idiomatic ruby once solid and heckled

      def load(path)
        Parser.new(path).parse
      end

    end # module ClassMethods

    extend ClassMethods


    attr_reader :generators
    attr_reader :publishers

  private

    def initialize(generators, publishers)
      @generators = generators || []
      @publishers = publishers || []
    end

  end # class Configuration
end # module Meterdata
