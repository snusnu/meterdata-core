require 'spec_helper'

require 'meterdata/report'

describe 'Meterdata::Report::Metadata#revision' do

  subject { metadata.revision }

  let(:metadata) { Meterdata::Report::Metadata.new }

  before(:all) do
    metadata.stub!(:raw_revision).and_return(raw_revision)
  end

  context 'when inside a git repository' do

    let(:raw_revision) { 'foo' }

    it { should == raw_revision }

  end

  context 'when not inside a git repository' do

    let(:raw_revision)  { 'fatal: Not a git repository' }

    it { should == nil }

  end

end
