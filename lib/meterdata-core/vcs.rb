require 'meterdata-core/exception'

module Meterdata

  class VCS

    class VCSError < Meterdata::Exception
    end

    class MissingVCS < VCSError
    end

    class MissingRevisionParser < VCSError
    end

    class MissingBranchParser < VCSError
    end

    class Factory

      def self.vcs(name)
        new(name).vcs
      end

    private

      def initialize(name)
        @name = name.capitalize
      end

      def vcs
        const_get(@name).new(revision_parser, branch_parser)
      rescue NameError
        error_msg = "'#{@name}' is no supported version control system"
        raise MissingVCS, error_msg
      end

      def revision_parser
        vcs.const_get(revision_parser_name).new
      rescue NameError
        raise MissingRevisionParser, parser_error_msg(revision_parser_name)
      end

      def branch_parser
        vcs.const_get(branch_parser_name).new
      rescue NameError
        raise MissingBranchParser, parser_error_msg(branch_parser_name)
      end

      def revision_parser_name
        "#{@name}RevisionParser"
      end

      def branch_parser_name
        "#{@name}BranchParser"
      end

      def parser_error_msg(parser)
        "'#{parser}#parse' must be implemented"
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

      attr_reader :revision
      attr_reader :current_branch

    end

    module ClassMethods # TODO use idiomatic ruby once solid and heckled

      def new(name)
        Factory.vcs(name)
      end

    end # module ClassMethods

    extend ClassMethods

    attr_reader :revision
    attr_reader :current_branch

    def initialize(parser)
      @revision = parser.parse
    end

    def available?
      raise NotImplementedError
    end

    def repository?
      raise NotImplementedError
    end

  end # class VCS
end # module Meterdata

