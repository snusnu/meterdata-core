require 'spec_helper'

require 'meterdata/report'

describe 'Meterdata::Report::Metadata::Engine#initialize' do

  subject { engine.logs }

  let(:engine) { Meterdata::Report::Metadata::Engine.new }

  it { should == {} }

end
