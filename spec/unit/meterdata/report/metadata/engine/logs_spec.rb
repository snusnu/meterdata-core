require 'spec_helper'

require 'meterdata-core/report'

describe 'Meterdata::Report::Metadata::Engine#initialize' do

  subject { engine.logs }

  let(:engine) { Meterdata::Report::Metadata::Engine.new }

  it { should == {} }

end
