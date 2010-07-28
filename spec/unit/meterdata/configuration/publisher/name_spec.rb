require 'spec_helper'

require 'meterdata-core/configuration'

require File.expand_path('../../component/name_spec', __FILE__)

describe 'Meterdata::Configuration::Publisher#name' do

  subject { publisher.name }

  let(:publisher) { Meterdata::Configuration::Publisher.new(config) }

  it_should_behave_like 'Meterdata::Configuration::Component#name'

end
