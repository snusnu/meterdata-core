require 'spec_helper'

require 'meterdata-core/configuration'

require File.expand_path('../../component/require_path_spec', __FILE__)

describe 'Meterdata::Configuration::Publisher#require_path' do

  subject { publisher.require_path }

  let(:require_path) { 'foo' }

  let(:config) {{
    'version'      => '0.0.1',
    'name'         => 'foo',
    'require_path' => require_path,
  }}

  let(:publisher) { Meterdata::Configuration::Publisher.new(config) }

  it_should_behave_like 'Meterdata::Configuration::Component#require_path'

end
