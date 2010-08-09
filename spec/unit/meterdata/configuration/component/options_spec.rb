require 'spec_helper'

shared_examples_for 'Meterdata::Configuration::Component#options' do

  context 'when no options were given' do

    let(:component) { klass.new(config) }

    it { should == {} }

  end

  context 'when options were given' do

    let(:options)   { {'a' => 'b'} }
    let(:component) { klass.new(config.merge('options' => options)) }

    it { should == options }

  end

end
