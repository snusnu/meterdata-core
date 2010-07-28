require 'spec_helper'

require 'meterdata-core/generator'
require File.expand_path('../fixtures/generator', __FILE__)

describe 'Meterdata::Generator#config' do

  subject { generator.config }

  let(:config) {
    Meterdata::Configuration::Generator.new({
      'version'      => '0.0.1',
      'name'         => 'Test',
      'require_path' => 'foo',
    })
  }

  let(:generator) { Meterdata::Generator.new(config) }

  it { should == config }

end
