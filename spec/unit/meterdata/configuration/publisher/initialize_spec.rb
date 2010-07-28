require 'spec_helper'

require 'meterdata-core/configuration'

require File.expand_path('../../component/initialize_spec', __FILE__)

describe 'Meterdata::Configuration::Publisher#initialize' do

  subject { Meterdata::Configuration::Publisher.new(config) }

  let(:component_name) { 'publisher' }

  it_should_behave_like 'Meterdata::Configuration::Component#initialize'

end
