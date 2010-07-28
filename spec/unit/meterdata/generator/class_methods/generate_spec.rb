require 'spec_helper'

require File.expand_path('../../fixtures/generator', __FILE__)
require File.expand_path('../../shared/run_spec', __FILE__)

describe 'Meterdata::Generator.generate' do

  subject { Meterdata::Generator.generate(config) }

  let(:version)      { '0.0.1' }
  let(:name)         { 'Test'  }
  let(:require_path) { 'foo'   }

  let(:config) {
    Meterdata::Configuration::Generator.new({
      'version'      => version,
      'name'         => name,
      'require_path' => require_path,
    })
  }

  it_should_behave_like 'a successful generator run'

end
