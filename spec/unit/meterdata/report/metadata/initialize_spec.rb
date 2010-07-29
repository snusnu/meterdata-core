require 'spec_helper'

require 'meterdata-core/report'

describe 'Meterdata::Report::Metadata#initialize' do

  shared_examples_for 'initializing metadata' do

    its(:engine)    { should be_kind_of(Meterdata::Report::Metadata::Engine) }
    its(:revision)  { should == revision }
    its(:timestamp) { should == now.to_i }

    its(:runtime) { should == {
      'RUBY_COPYRIGHT'    => RUBY_COPYRIGHT,
      'RUBY_DESCRIPTION'  => RUBY_DESCRIPTION,
      'RUBY_ENGINE'       => RUBY_ENGINE,
      'RUBY_PLATFORM'     => RUBY_PLATFORM,
      'RUBY_RELEASE_DATE' => RUBY_RELEASE_DATE,
      'RUBY_VERSION'      => RUBY_VERSION,
      'RUBY_PATCHLEVEL'   => RUBY_PATCHLEVEL,
    }}

  end

  before(:all) do
    Time.stub!(:now).and_return(now)
    Meterdata::Report::Metadata::VCS.stub!(:revision).and_return(revision)
  end

  let(:now) { Time.mktime(1970,1,1) }

  subject { Meterdata::Report::Metadata.new }

  context 'when inside a git repository' do

    let(:revision) { :foo }

    it_should_behave_like 'initializing metadata'

  end

  context 'when not inside a git repository' do

    let(:revision) { nil }

    it_should_behave_like 'initializing metadata'

  end

end
