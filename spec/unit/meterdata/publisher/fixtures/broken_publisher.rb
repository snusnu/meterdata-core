require 'meterdata-core/publisher'

module Meterdata
  class Publisher
    class BrokenTest < Publisher
      # Broken because #publish is not implemented
    end
  end
end

