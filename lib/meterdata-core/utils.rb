module Meterdata
  module Utils

  private

    def demodulize(name)
      name.to_s.gsub(/^.*::/, '')
    end

  end
end
