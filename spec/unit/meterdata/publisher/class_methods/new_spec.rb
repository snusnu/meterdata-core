require 'spec_helper'

require 'spec_helper'

require 'meterdata/publisher'
require File.expand_path('../../fixtures/successful_publisher', __FILE__)

describe 'Meterdata::Publisher.new' do

  shared_examples_for 'instantiating a new publisher' do

    let(:config) {
      Meterdata::Configuration::Publisher.new({
        'version'      => '0.0.1',
        'name'         => name,
        'require_path' => 'foo',
      })
    }

    let(:report) { {} }

    context 'with a known publisher' do

      let(:name) { 'SuccessfulTest' }

      it { should be_kind_of(Meterdata::Publisher::SuccessfulTest) }

    end

    context 'with an unknown publisher' do

      let(:name)      { 'foo' }
      let(:error_msg) { "The '#{name}' publisher could not be found in the Meterdata::Publisher class" }

      specify do
        expect { subject }.to raise_error(Meterdata::Publisher::UnsupportedPublisher, error_msg)
      end

    end

  end

  context 'when called on the class itself' do

    subject { Meterdata::Publisher.new(config, report) }

    it_should_behave_like 'instantiating a new publisher'

  end

  context 'when called on a subclass' do

    subject { Meterdata::Publisher::SuccessfulTest.new(config, report) }

    it_should_behave_like 'instantiating a new publisher'

  end

end
