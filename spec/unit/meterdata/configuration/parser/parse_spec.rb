require 'spec_helper'

require 'meterdata/configuration'

require File.expand_path('../shared/parse_spec', __FILE__)

describe 'Meterdata::Configuration::Parser#parse' do

  subject { parser.parse }

  context 'with a compliant configuration parser' do
    it_should_behave_like 'a compliant configuration parser'
  end

  context 'with a non compliant configuration parser' do
    it_should_behave_like 'a non compliant configuration parser'
  end

end
