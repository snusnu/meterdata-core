require 'spec_helper'

require 'meterdata-core/configuration'

require File.expand_path('../../component/require_path_spec', __FILE__)

describe 'Meterdata::Configuration::Generator#require_path' do

  subject { generator.require_path }

  let(:generator) { Meterdata::Configuration::Generator.new(config) }

  it_should_behave_like 'Meterdata::Configuration::Component#require_path'

end
