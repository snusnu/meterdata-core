require 'spec_helper'

require 'meterdata-core/configuration'

require File.expand_path('../../component/options_spec', __FILE__)

describe 'Meterdata::Configuration::Publisher#options' do

  subject { generator.options }

  let(:klass)     { Meterdata::Configuration::Publisher }
  let(:generator) { component }

  it_should_behave_like 'Meterdata::Configuration::Component#options'

end