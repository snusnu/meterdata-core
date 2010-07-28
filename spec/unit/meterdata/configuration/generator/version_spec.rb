require 'spec_helper'

require 'meterdata-core/configuration'

require File.expand_path('../../component/version_spec', __FILE__)

describe 'Meterdata::Configuration::Generator#version' do

  subject { generator.version }

  let(:generator) { Meterdata::Configuration::Generator.new(config) }

  it_should_behave_like 'Meterdata::Configuration::Component#version'

end
