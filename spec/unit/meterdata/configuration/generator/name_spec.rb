require 'spec_helper'

require 'meterdata-core/configuration'

require File.expand_path('../../component/name_spec', __FILE__)

describe 'Meterdata::Configuration::Generator#name' do

  subject { generator.name }

  let(:generator) { Meterdata::Configuration::Generator.new(config) }

  it_should_behave_like 'Meterdata::Configuration::Component#name'

end
