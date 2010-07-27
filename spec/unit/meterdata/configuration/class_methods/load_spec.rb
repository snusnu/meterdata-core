require 'spec_helper'

require 'meterdata-core/configuration'

require File.expand_path('../../parser/shared/parse_spec', __FILE__)

describe 'Meterdata::Configuration.load' do

  subject { Meterdata::Configuration.load(path) }

  let(:path) { File.expand_path('../../fixtures/valid_meterdata.yml', __FILE__) }

  it_should_behave_like 'a compliant configuration parser'

end
