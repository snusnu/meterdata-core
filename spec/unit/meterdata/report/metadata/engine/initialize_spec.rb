require 'spec_helper'

require 'meterdata-core/report'

describe 'Meterdata::Report::Metadata::Engine#initialize' do

  subject { Meterdata::Report::Metadata::Engine.new }

  its(:version) { should == Meterdata::VERSION }
  its(:logs)    { should == {} }

end
