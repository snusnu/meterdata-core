require 'spec_helper'

require File.expand_path('../../shared/revision_spec', __FILE__)

describe "Meterdata::Report::Metadata::VCS.revision" do

  subject { Meterdata::Report::Metadata::VCS.revision }

  it_should_behave_like "a working VCS implementation"

end

