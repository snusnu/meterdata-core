require 'spec_helper'

require 'meterdata/generator'
require File.expand_path('../fixtures/successful_generator', __FILE__)

describe 'Meterdata::Generator#config' do

  subject { generator.config }

  let(:config) {
    Meterdata::Configuration::Generator.new({
      'version'      => '0.0.1',
      'name'         => 'SuccessfulTest',
      'require_path' => File.expand_path('../fixtures/successful_generator', __FILE__),
    })
  }

  let(:generator) { Meterdata::Generator.new(config) }

  it { should == config }

end
