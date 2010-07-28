require 'spec_helper'

require 'meterdata-core/configuration'

describe 'Meterdata::Configuration#generators' do

  subject { configuration.generators }

  let(:publishers) { nil }

  shared_examples_for 'the Meterdata::Configuration#generators reader' do

    let(:configuration)   { Meterdata::Configuration.new(generators, publishers) }
    
    it { should == expected_result }

  end

  context 'when nil was given as initial generators' do

    let(:generators)      { nil }
    let(:expected_result) { []  }

    it_should_behave_like 'the Meterdata::Configuration#generators reader'

  end

  context 'when an empty array of generators was given' do

    let(:generators)      {[]}
    let(:expected_result) { generators }

    it_should_behave_like 'the Meterdata::Configuration#generators reader'

  end

  context 'when an array containing one generator was passed' do

    let(:generators) {[
      Meterdata::Configuration::Generator.new({
        'version'      => '0.0.1',
        'name'         => 'Test',
        'require_path' => 'foo',
      })]
    }

    let(:expected_result) { generators }

    it_should_behave_like 'the Meterdata::Configuration#generators reader'

  end

end
