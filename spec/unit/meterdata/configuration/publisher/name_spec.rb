require 'spec_helper'

require 'meterdata/configuration'

require File.expand_path('../../component/name_spec', __FILE__)

describe 'Meterdata::Configuration::Publisher#name' do

  subject { publisher.name }

  let(:name) { 'foo' }

  let(:config) {{
    'version'      => '0.0.1',
    'name'         => name,
    'require_path' => 'foo',
  }}

  let(:publisher) { Meterdata::Configuration::Publisher.new(config) }

  it_should_behave_like 'Meterdata::Configuration::Component#name'

end
