module Meterdata

  class Shell

    def invoke(cmd)
      `#{cmd}`
    end

  end # class Shell

end # module Meterdata
