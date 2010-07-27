require 'spec_helper'

require 'meterdata-core/configuration'

describe 'Meterdata::Configuration::Generator#initialize' do

  shared_examples_for 'a generator constructor' do

    let(:options) { {} }

    context 'when all required keys are present' do

      let(:name)         { 'foo' }
      let(:require_path) { 'foo' }

      specify { expect { subject }.to_not raise_error(Meterdata::Configuration::Generator::IncompleteError) }

    end

    context 'when the name key is missing' do

      let(:name)         {  nil  }
      let(:require_path) { 'foo' }

      specify do
        msg = "The following generator key(s) are missing: name"
        expect { subject }.to raise_error(Meterdata::Configuration::Generator::IncompleteError, msg)
      end

    end

    context 'when the require_path key is missing' do

      let(:name)         { 'foo' }
      let(:require_path) {  nil  }

      specify do
        msg = "The following generator key(s) are missing: require_path"
        expect { subject }.to raise_error(Meterdata::Configuration::Generator::IncompleteError, msg)
      end

    end

    context 'when both the name and the require_path keys are missing' do

      let(:name)         { nil }
      let(:require_path) { nil }

      specify do
        msg = "The following generator key(s) are missing: name, require_path"
        expect { subject }.to raise_error(Meterdata::Configuration::Generator::IncompleteError, msg)
      end

    end

  end

  context 'with no options given' do

    subject { Meterdata::Configuration::Generator.new(name, require_path) }

    it_should_behave_like 'a generator constructor'

    # rspec seems to need those

    let(:name)         { 'foo' }
    let(:require_path) { 'foo' }

    its(:options) { should == {} }

  end

  context 'with options given' do

    subject { Meterdata::Configuration::Generator.new(name, require_path, options) }

    it_should_behave_like 'a generator constructor'

  end

end
