require 'spec_helper'

require 'meterdata-core/generator'
require File.expand_path('../fixtures/generator', __FILE__)

describe 'Meterdata::Generator#options' do

  subject { generator.options }

  let(:options)   {                  {}                      }
  let(:generator) { Meterdata::Specs::Generator.new(options) }

  it { should == options }

end
