module Meterdata

  class Report

    def self.working_directory
      Pathname.new(Dir.pwd).join('.tmp')
    end

    class InvalidMetadata < Meterdata::Error; end

    class Metadata

      class Environment

        attr_reader :os
        attr_reader :runtime

        def initialize(os, runtime)

        end

      end

      class Generator

        attr_reader :name
        attr_reader :version

      end

      attr_reader :timestamp
      attr_reader :commit_sha
      attr_reader :generator

    end

  end

end
