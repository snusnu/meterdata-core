require 'spec'
require 'spec/autorun'

require 'meterdata'

module Meterdata
  module Specs

    def self.root
      @root ||= Pathname(File.dirname(__FILE__))
    end

  end
end
