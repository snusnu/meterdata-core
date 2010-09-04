require 'spec_helper'

require 'meterdata/publisher'

describe 'Meterdata::Publisher#config' do

  subject { publisher.config }

  let(:config) {
    Meterdata::Configuration::Publisher.new({
      'version'      => '0.0.1',
      'name'         => 'SuccessfulTest',
      'require_path' => File.expand_path('../fixtures/successful_publisher', __FILE__),
    })
  }

  let(:report) { {} }

  let(:publisher) { Meterdata::Publisher.new(config, report) }

  it { should == config }

end
