require 'spec_helper'

require 'meterdata-core/report'

require File.expand_path('../../fixtures/broken_vcs', __FILE__)

shared_examples_for 'a working VCS implementation' do

  it { should_not raise_error(NotImplementedError) }
  it { should_not be_nil }

end

shared_examples_for 'a broken VCS implementation' do

  specify do
    msg = "Meterdata::Specs::BrokenVcs#revision must be implemented"
    expect { subject }.to raise_error(NotImplementedError, msg)
  end

end

