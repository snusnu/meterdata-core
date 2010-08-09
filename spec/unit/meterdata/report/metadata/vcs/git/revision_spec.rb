require 'spec_helper'

require File.expand_path('../../shared/revision_spec', __FILE__)

describe "Meterdata::Report::Metadata::VCS::Git#revision" do

  subject { vcs.revision }

  let(:vcs) { Meterdata::Report::Metadata::VCS::Git.new }

  it_should_behave_like "a working VCS implementation"

end

