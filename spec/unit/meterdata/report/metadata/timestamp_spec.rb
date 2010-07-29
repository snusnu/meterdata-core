require 'spec_helper'

require 'meterdata-core/report'

describe 'Meterdata::Report::Metadata#timestamp' do

  subject { metadata.timestamp }

  let(:now) { Time.now.to_i }

  let(:metadata)  {
    metadata = Meterdata::Report::Metadata.new
    metadata.stub!(:timestamp).and_return(now)
    metadata
  }

  it { should be_kind_of(Integer) }
  it { should == now }

end
