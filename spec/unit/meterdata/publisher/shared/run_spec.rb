require 'spec_helper'

shared_examples_for 'a successful publishing' do

  let(:report) { {} }

  let(:version)      { '0.0.1' }
  let(:name)         { 'Test'  }
  let(:require_path) { 'foo'   }

  let(:config) {
    Meterdata::Configuration::Publisher.new({
      'version'      => version,
      'name'         => name,
      'require_path' => require_path,
    })
  }

  it { should == true }

end
