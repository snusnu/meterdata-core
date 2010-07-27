require 'spec_helper'

require 'meterdata-core/configuration'

describe 'Meterdata::Configuration::Generator#options' do

  subject { generator.options }

  let(:name)         { 'foo' }
  let(:require_path) { 'foo' }
  let(:options)      {  {}   }
  let(:generator)    { Meterdata::Configuration::Generator.new(name, require_path, options) }

  it { should == {} }

end
