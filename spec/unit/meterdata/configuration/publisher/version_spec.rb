require 'spec_helper'

require 'meterdata-core/configuration'

require File.expand_path('../../component/version_spec', __FILE__)

describe 'Meterdata::Configuration::Publisher#version' do

  subject { publisher.version }

  let(:publisher) { Meterdata::Configuration::Publisher.new(config) }

  it_should_behave_like 'Meterdata::Configuration::Component#version'

end
