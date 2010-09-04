require 'spec_helper'

require 'meterdata/report'

describe 'Meterdata::Report::Metadata#engine' do

  subject { metadata.engine }

  let(:metadata) { Meterdata::Report::Metadata.new }

  it { should be_kind_of(Meterdata::Report::Metadata::Engine) }

end
