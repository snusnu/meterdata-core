require 'erb'

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
        Configuration.new(generators)
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
        config['generators'].map do |config|
          Generator.new(config['name'], config['require_path'], config['options'])
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


    class Generator

      class IncompleteError < Meterdata::Exception
      end

      attr_reader :name
      attr_reader :require_path
      attr_reader :options

      def initialize(name, require_path, options = {})
        @name, @require_path, @options = name, require_path, options
        raise IncompleteError, "The following generator key(s) are missing: #{missing_keys.join(', ')}" unless valid?
      end

    private

      def valid?
        missing_keys.empty?
      end

      def missing_keys
        required_keys.select { |key| send(key).nil? }
      end

      def required_keys
        %w[name require_path]
      end

    end # class Generator


    module ClassMethods # TODO use idiomatic ruby once solid and heckled

      def load(path)
        Parser.new(path).parse
      end

    end # module ClassMethods

    extend ClassMethods


    attr_reader :generators

  private

    def initialize(generators)
      @generators = generators
    end

  end # class Configuration
end # module Meterdata
