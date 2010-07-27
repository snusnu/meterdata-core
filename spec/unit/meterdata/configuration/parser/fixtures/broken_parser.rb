module Meterdata
  module Specs
    class Configuration
      class Parser
        class BrokenParser < Meterdata::Configuration::Parser
          # broken because it's missing an implementation of Parser#load
        end
      end
    end
  end
end
