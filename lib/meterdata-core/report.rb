require 'json'

require 'meterdata-core/version'

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
              'name'    => report.generator.name,
              'version' => report.generator.version,
              'options' => report.generator.options,
            },
            'result' => report.result,
            'errors' => report.errors,
          }
        end
      end

      def engine(object)
        {
          'version' => object.version,
          'log'     => object.log,
        }
      end

    end

    class Metadata

      class Engine

        attr_reader :version
        attr_reader :log

        def initialize
          @version, @log = Meterdata::VERSION, {}
        end

        def log(level, key, message)
          ((@log[level.to_s] ||= {})[key.to_s] ||= []) << message.to_s
        end

      end

      attr_reader :engine
      attr_reader :timestamp
      attr_reader :revision
      attr_reader :runtime

      def initialize
        set_timestamp
        set_revision
        set_runtime
        set_engine
      end

      def log(level, key, message)
        engine.log(level, key, message)
      end

    private

      def set_engine
        @engine = Metadata::Engine.new
      end

      def set_timestamp
        @timestamp = Time.now.to_i
      end

      def set_revision
        git_output = `git rev-parse head`
        @revision = (git_output =~ /fatal: Not a git repository/) ? nil : git_output
      end

      def set_runtime
        @runtime = {
          'RUBY_COPYRIGHT'    => RUBY_COPYRIGHT,
          'RUBY_DESCRIPTION'  => RUBY_DESCRIPTION,
          'RUBY_ENGINE'       => RUBY_ENGINE,
          'RUBY_PLATFORM'     => RUBY_PLATFORM,
          'RUBY_RELEASE_DATE' => RUBY_RELEASE_DATE,
          'RUBY_VERSION'      => RUBY_VERSION,
          'RUBY_PATCHLEVEL'   => RUBY_PATCHLEVEL,
        }
      end

    end

    attr_reader :metadata
    attr_reader :reports

    def initialize
      @metadata = Metadata.new
      @reports  = []
    end

    def add(report)
      @reports << report
    end

    def log(level, key, message)
      @metadata.log(level, key, message)
    end

    def serialize
      Serializer.serialize(self)
    end

  end # class Report
end # module Meterdata
