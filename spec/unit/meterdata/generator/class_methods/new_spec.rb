require 'spec_helper'

require 'meterdata/generator'
require File.expand_path('../../fixtures/successful_generator', __FILE__)

describe 'Meterdata::Generator.new' do

  shared_examples_for 'instantiating a new generator' do

    let(:config) {
      Meterdata::Configuration::Generator.new({
        'version'      => '0.0.1',
        'name'         => name,
        'require_path' => File.expand_path('../../fixtures/successful_generator', __FILE__),
      })
    }

    context 'with a known generator' do

      let(:name) { 'SuccessfulTest' }

      it { should be_kind_of(Meterdata::Generator::SuccessfulTest) }

    end

    context 'with an unknown generator' do

      let(:name)      { 'foo' }
      let(:error_msg) { "The '#{name}' generator could not be found in the Meterdata::Generator class" }

      specify do
        expect { subject }.to raise_error(Meterdata::Generator::UnsupportedGenerator, error_msg)
      end

    end

  end

  context 'when called on the class itself' do

    subject { Meterdata::Generator.new(config) }

    it_should_behave_like 'instantiating a new generator'

  end

  context 'when called on a subclass' do

    subject { Meterdata::Generator::SuccessfulTest.new(config) }

    it_should_behave_like 'instantiating a new generator'

  end

end
