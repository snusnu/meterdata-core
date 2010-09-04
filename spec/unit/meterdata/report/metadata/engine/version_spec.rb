require 'spec_helper'

require 'meterdata/report'

describe 'Meterdata::Report::Metadata::Engine#initialize' do

  subject { engine.version }

  let(:engine) { Meterdata::Report::Metadata::Engine.new }

  it { should == Meterdata::VERSION }

end
