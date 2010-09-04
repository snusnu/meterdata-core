require 'spec_helper'

require 'meterdata/configuration'

describe 'Meterdata::Configuration#publishers' do

  subject { configuration.publishers }

  let(:generators) { nil }

  shared_examples_for 'the Meterdata::Configuration#publishers reader' do

    let(:configuration)   { Meterdata::Configuration.new(generators, publishers) }

    it { should == expected_result }

  end

  context 'when nil was given as initial publishers' do

    let(:publishers)      { nil }
    let(:expected_result) { []  }

    it_should_behave_like 'the Meterdata::Configuration#publishers reader'

  end

  context 'when an empty array of publishers was given' do

    let(:publishers)      {[]}
    let(:expected_result) { publishers }

    it_should_behave_like 'the Meterdata::Configuration#publishers reader'

  end

  context 'when an array containing one publishers was passed' do

    let(:publishers) {[
      Meterdata::Configuration::Publisher.new({
        'version'      => '0.0.1',
        'name'         => 'Test',
        'require_path' => 'foo',
      })]
    }

    let(:expected_result) { publishers }

    it_should_behave_like 'the Meterdata::Configuration#publishers reader'

  end

end
