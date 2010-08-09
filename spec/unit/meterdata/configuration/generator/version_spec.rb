require 'spec_helper'

require 'meterdata-core/configuration'

require File.expand_path('../../component/version_spec', __FILE__)

describe 'Meterdata::Configuration::Generator#version' do

  subject { generator.version }

  let(:version) { '0.0.1' }

  let(:config) {{
    'version'      => version,
    'name'         => 'foo',
    'require_path' => 'foo',
  }}

  let(:generator) { Meterdata::Configuration::Generator.new(config) }

  it_should_behave_like 'Meterdata::Configuration::Component#version'

end
