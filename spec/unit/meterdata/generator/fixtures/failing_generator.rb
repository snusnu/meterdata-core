require 'meterdata-core/generator'

module Meterdata
  class Generator
    class FailingTest < Generator

      def generate
        raise RuntimeError, 'Something bad happened'
      end

    end
  end
end

