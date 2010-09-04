require 'pathname'

module Meterdata

  def self.working_directory=(path)
    @working_directory = Pathname(path)
  end

  def self.working_directory
    @working_directory ||= Pathname(Dir.pwd)
  end

end

require 'meterdata/engine'

