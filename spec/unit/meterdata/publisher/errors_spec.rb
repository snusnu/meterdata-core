require 'spec_helper'

require 'meterdata-core/publisher'
require File.expand_path('../fixtures/publisher', __FILE__)

describe 'Meterdata::Publisher#errors' do

  subject { publisher.errors }

  let(:config) {
    Meterdata::Configuration::Publisher.new({
      'version'      => '0.0.1',
      'name'         => 'Test',
      'require_path' => 'foo',
    })
  }

  let(:report) { {} }

  let(:publisher) { Meterdata::Publisher.new(config, report) }


  context 'when no errors have been added' do

    it { should == [] }

  end

  context 'when errors have been added' do

    it 'should return those errors' do
      publisher.errors << 'error'
      subject.should == [ 'error' ]
    end

  end

end
