require 'spec_helper'

require File.expand_path('../shared/revision_spec', __FILE__)

describe "Meterdata::Report::Metadata::VCS#revision" do

  context 'with a working VCS implementation' do

    subject { vcs.revision }

    let(:vcs) { Meterdata::Report::Metadata::VCS::Git.new }

    it_should_behave_like "a working VCS implementation"

  end

  context 'with a broken VCS implementation' do

    subject { vcs.revision }

    let(:vcs) { Meterdata::Specs::BrokenVcs.new }

    it_should_behave_like "a broken VCS implementation"

  end

end

