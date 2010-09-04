require 'meterdata/exception'

module Meterdata

  class VCS

    include Component

    class Error < Meterdata::Exception
      def initialize(name)
        @name = name
      end
    end

    class MissingVCS < Error
    end

    class MissingRevisionParser < Error
    end

    class MissingBranchParser < Error
    end

    class Factory

      def self.new(vcs, name)
        name == 'Factory'
      end

      # Must be implemented by all factory implementations
      # Must return an instance of a Meterdata::VCS descendant
      def vcs
        const_get(name).new(revision_parser, branch_parser)
      rescue NameError
        raise MissingVCS.new(name)
      end

    private

      attr_reader :name

      def initialize(name)
        @name = name
      end

      def revision_parser
        vcs.const_get(revision_parser_name).new
      rescue NameError
        raise MissingRevisionParser.new(revision_parser_name)
      end

      def branch_parser
        vcs.const_get(branch_parser_name).new
      rescue NameError
        raise MissingBranchParser.new(branch_parser_name)
      end

      def vcs_name
        @name.capitalize
      end

      def revision_parser_name
        "#{name}RevisionParser"
      end

      def branch_parser_name
        "#{name}BranchParser"
      end

    end

    class Git < VCS

      class RevisionParser

        def parse
          revision.chomp
        end

      private

        def revision
          %x{git rev-parse HEAD 2> /dev/null}
        end

      end

      class BranchParser

        def parse
         (branch.grep(/^\*/).first || '').sub(/^\* (.+)$/, '\1').chomp
        end

      private

        def branch
          %x{git branch 2> /dev/null}
        end

      end

      def available?
        not %x{git --version 2> /dev/null}.chomp.empty?
      end

      def repository?
        File.directory?(Meterdata.working_directory.join('.git'))
      end

    end

    module ClassMethods # TODO use idiomatic ruby once solid and heckled

      def new(name)
        Factory.vcs(name)
      end

    end # module ClassMethods

    extend ClassMethods

    attr_reader :current_revision
    attr_reader :current_branch

    def initialize(revision_parser, branch_parser)
      @current_revision = revision_parser.parse
      @current_branch   = branch_parser.parse
    end

    def available?
      raise NotImplementedError
    end

    def repository?
      raise NotImplementedError
    end

    def _current_revision
      revision_parser.parse
    end

    def _current_branch
      branch_parser.parse
    end

  end # class VCS
end # module Meterdata

