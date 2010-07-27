require 'spec_helper'

require 'meterdata-core/generator'
require File.expand_path('../../fixtures/generator', __FILE__)

describe 'Meterdata::Generator.instantiate' do

  shared_examples_for 'instantiate' do

    context 'with an unknown generator' do

      let(:name)    { 'Unknown' }
      let(:options) {    nil    }

      specify do
        expected_error_msg = "The '#{name}' generator could not be found"
        expect { subject }.to raise_error(Meterdata::UnsupportedGenerator, expected_error_msg)
      end

    end

    context 'with a known generator' do

      let(:name)    { 'Meterdata::Specs::Generator' }
      let(:options) {             nil               }

      it { should be_kind_of(Meterdata::Specs::Generator) }

    end

  end

  context 'when called on the class itself' do

    subject { Meterdata::Generator.instantiate(name, options) }

    it_should_behave_like 'instantiate'

  end

  context 'when called on a subclass' do

    subject { Meterdata::Specs::Generator.instantiate(name, options) }

    it_should_behave_like 'instantiate'

  end

end
