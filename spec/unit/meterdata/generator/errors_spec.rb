require 'spec_helper'

require 'meterdata/generator'
require File.expand_path('../fixtures/successful_generator', __FILE__)

describe 'Meterdata::Generator#errors' do

  subject { generator.errors }

  let(:config) {
    Meterdata::Configuration::Generator.new({
      'version'      => '0.0.1',
      'name'         => 'SuccessfulTest',
      'require_path' => File.expand_path('../fixtures/successful_generator', __FILE__),
    })
  }

  let(:generator) { Meterdata::Generator.new(config) }

  context 'when no errors have been added' do

    it { should == [] }

  end

  context 'when errors have been added' do

    it 'should return those errors' do
      generator.errors << 'error'
      subject.should == [ 'error' ]
    end

  end

end
