require 'spec_helper'

require 'meterdata-core/configuration'

require File.expand_path('../../component/options_spec', __FILE__)

describe 'Meterdata::Configuration::Generator#options' do

  subject { generator.options }

  let(:config) {{
    'version'      => '0.0.1',
    'name'         => 'foo',
    'require_path' => 'foo',
  }}

  let(:klass)     { Meterdata::Configuration::Generator }
  let(:generator) { component }

  it_should_behave_like 'Meterdata::Configuration::Component#options'

end
