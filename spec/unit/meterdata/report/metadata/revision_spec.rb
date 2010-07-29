require 'spec_helper'

require 'meterdata-core/report'

describe 'Meterdata::Report::Metadata#revision' do

  shared_examples_for 'a metadata revision' do

    let(:metadata)  {
      metadata = Meterdata::Report::Metadata.new
      metadata.stub!(:revision).and_return(revision)
      metadata
    }

    it { should == revision }

  end

  subject { metadata.revision }

  context 'when inside a git repository' do

    let(:revision) { `git rev-parse HEAD` }

    it_should_behave_like 'a metadata revision'

  end

  context 'when not inside a git repository' do

    let(:revision)  { nil }

    it_should_behave_like 'a metadata revision'

  end

end
