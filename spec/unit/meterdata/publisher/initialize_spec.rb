require 'spec_helper'

require 'meterdata-core/publisher'

describe 'Meterdata::Publisher#published?' do

  subject { Meterdata::Publisher.new(config, report) }

  let(:report) { {} }

  let(:config) {
    Meterdata::Configuration::Publisher.new({
      'version'      => '0.0.1',
      'name'         => 'SuccessfulTest',
      'require_path' => File.expand_path('../fixtures/successful_publisher', __FILE__),
    })
  }

  its(:config) { should == config }
  its(:report) { should == report }

  it { subject.published?.should == false }

end

