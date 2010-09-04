require 'spec_helper'

require 'meterdata/configuration'

require File.expand_path('../../parser/shared/parse_spec', __FILE__)

describe 'Meterdata::Configuration.load' do

  subject { Meterdata::Configuration.load(path) }

  it_should_behave_like 'a compliant configuration parser'

end
