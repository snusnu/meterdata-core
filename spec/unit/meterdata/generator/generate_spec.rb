require 'spec_helper'

require 'meterdata-core/generator'

require File.expand_path('../fixtures/successful_generator', __FILE__)
require File.expand_path('../fixtures/broken_generator', __FILE__)

describe 'Meterdata::Generator#generate' do

  subject { generator.generate }

  let(:generator) { Meterdata::Generator.new(config) }

  let(:config) {
    Meterdata::Configuration::Generator.new({
      'version'      => '0.0.1',
      'name'         => name,
      'require_path' => require_path,
    })
  }

  context 'with a successful generator' do

    let(:name)         { 'SuccessfulTest' }
    let(:require_path) { File.expand_path('../fixtures/successful_generator', __FILE__) }

    it { should be_true }

  end

  context 'with a broken generator' do

    let(:name)         { 'BrokenTest' }
    let(:require_path) { File.expand_path('../fixtures/broken_generator', __FILE__) }

    specify do
      msg = "Meterdata::Generator::BrokenTest#generate must be implemented"
      expect { subject }.to raise_error(NotImplementedError, msg)
    end

  end

end

