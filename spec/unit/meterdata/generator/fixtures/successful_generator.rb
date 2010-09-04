require 'meterdata/generator'

module Meterdata
  class Generator
    class SuccessfulTest < Generator

      def generate
        result << 'generate'
        result
      end

      # these are for testing execution order

      def result
        @result ||= []
      end

      def before_generate
        result << 'before_generate'
      end

      def after_generate
        result << 'after_generate'
      end

    end
  end
end
