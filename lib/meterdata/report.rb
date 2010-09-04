require 'json'

require 'meterdata/exception'
require 'meterdata/version'

module Meterdata

  class Report

    class Serializer

      module ClassMethods # TODO use idiomatic ruby once solid and heckled

        def serialize(report)
          new(report).serialize
        end

      end # module ClassMethods

      extend ClassMethods

      def serialize
        {
          'metadata' => metadata(@report.metadata),
          'reports'  => reports(@report.reports),
        }.to_json
      end

    private

      def initialize(report)
        @report = report
      end

      def metadata(object)
        {
          'engine'    => engine(object.engine),
          'timestamp' => object.timestamp,
          'revision'  => object.revision,
          'runtime'   => object.runtime,
        }
      end

      def reports(array)
        array.map do |report|
          {
            'generator' => {
              'name'    => report.config.name,
              'version' => report.config.version,
              'options' => report.config.options,
            },
            'result' => report.result,
            'errors' => report.errors,
          }
        end
      end

      def engine(object)
        {
          'version' => object.version,
          'log'     => object.logs,
        }
      end

    end

    class Metadata

      class Engine

        attr_reader :version
        attr_reader :config

        def initialize(config)
          @version, @config = Meterdata::VERSION, config
        end

      end


      attr_reader :timestamp
      attr_reader :engine
      attr_reader :runtime
      attr_reader :vcs
      attr_reader :logs

      def initialize(config)
        @timestamp = Time.now.to_i
        @engine    = Metadata::Engine.new(config)
        @vcs       = VCS.new(config.vcs.name)
        @logs      = {}
        @runtime   = {
          'RUBY_DESCRIPTION'  => RUBY_DESCRIPTION,
          'RUBY_ENGINE'       => RUBY_ENGINE,
          'RUBY_PLATFORM'     => RUBY_PLATFORM,
          'RUBY_RELEASE_DATE' => RUBY_RELEASE_DATE,
          'RUBY_VERSION'      => RUBY_VERSION,
          'RUBY_PATCHLEVEL'   => RUBY_PATCHLEVEL,
        }
      end

    end

    class Log

      def self.levels
        [:debug, :info, :warn, :error].freeze
      end

      levels.each do |level|
        class_eval <<-RUBY, __FILE__, __LINE__ + 1
          def #{level}(message)
            log(:#{level}, message)
          end
        RUBY
      end

      attr_reader :entries

      def initialize
        @entries = {}
        self.class.levels.each do |level|
          @entries[level] = []
        end
      end

      def log(level, message)
        entries[level.to_sym] << message.to_s
      end

    end

    attr_reader :metadata
    attr_reader :reports
    attr_reader :log

    def initialize(config)
      @metadata = Metadata.new(config)
      @log      = Log.new
      @reports  = []
    end

    def add(report)
      @reports << report
    end

  end # class Report
end # module Meterdata

