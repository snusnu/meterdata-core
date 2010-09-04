require 'spec_helper'

require 'meterdata/configuration'

require File.expand_path('../../component/initialize_spec', __FILE__)

describe 'Meterdata::Configuration::Generator#initialize' do

  subject { Meterdata::Configuration::Generator.new(config) }

  let(:component_name) { 'generator' }

  it_should_behave_like 'Meterdata::Configuration::Component#initialize'

end
