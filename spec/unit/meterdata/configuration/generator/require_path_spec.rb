require 'spec_helper'

require 'meterdata-core/configuration'

describe 'Meterdata::Configuration::Generator#require_path' do

  subject { generator.require_path }

  let(:name)         { 'foo' }
  let(:require_path) { 'foo' }
  let(:options)      {  {}   }
  let(:generator)    { Meterdata::Configuration::Generator.new(name, require_path, options) }

  it { should == 'foo' }

end
