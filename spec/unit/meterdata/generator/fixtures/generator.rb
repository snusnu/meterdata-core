require 'meterdata-core/generator'

module Meterdata
  module Specs

    class Generator < ::Meterdata::Generator

      def emit
        'raw output'
      end

      def analyze
        'analyzed output'
      end

      def generate
        'report'
      end

      def publish
        true
      end

    private

      def hook_recorder
        @calls ||= []
      end

      %w[
        before_emit
        after_emit
        before_analyze
        after_analyze
        before_generate
        after_generate
        before_publish
        after_publish
      ].each do |hook|

        define_method hook do
          hook_recorder << hook
        end

      end

    end

  end
end
