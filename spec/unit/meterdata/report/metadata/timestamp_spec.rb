require 'spec_helper'

require 'meterdata/report'

describe 'Meterdata::Report::Metadata#timestamp' do

  let(:now)       { Time.mktime(1970,1,1) }
  let(:metadata)  { Meterdata::Report::Metadata.new }

  before(:all) do
    Time.stub!(:now).and_return(now)
  end

  subject { metadata.timestamp }

  it { should == now.to_i }

end
