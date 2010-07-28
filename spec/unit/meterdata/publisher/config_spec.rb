require 'spec_helper'

require 'meterdata-core/publisher'
require File.expand_path('../fixtures/publisher', __FILE__)

describe 'Meterdata::Publisher#config' do

  subject { publisher.config }

  let(:config) {
    Meterdata::Configuration::Publisher.new({
      'version'      => '0.0.1',
      'name'         => 'Test',
      'require_path' => 'foo',
    })
  }

  let(:report) { {} }

  let(:publisher) { Meterdata::Publisher.new(config, report) }

  it { should == config }

end
