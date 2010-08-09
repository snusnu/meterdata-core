module Meterdata
  class Publisher
    class FailingTest < Publisher

      def publish
        result << 'publish'
        false
      end

      # these are for testing execution order

      def result
        @result ||= []
      end

      def before_publish
        result << 'before_publish'
      end

      def after_publish
        result << 'after_publish'
      end

    end
  end
end

