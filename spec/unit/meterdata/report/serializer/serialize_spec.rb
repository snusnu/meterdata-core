require 'spec_helper'

require 'meterdata/report'

require File.expand_path('../shared/serialize_spec', __FILE__)

describe "Meterdata::Report::Serializer#serialize" do

  subject { serializer.serialize }

  let(:serializer)  { Meterdata::Report::Serializer.new(report) }

  let(:report)      { Meterdata::Report.new }

  let(:config) {
    Meterdata::Configuration::Generator.new({
      'version'      => '0.0.1',
      'name'         => 'Foo',
      'require_path' => 'foo',
      'options'      => { 'foo' => 'bar' },
    })
  }

  let(:result)      { {} }
  let(:errors)      { [] }

  let(:generator_report) { Meterdata::Generator::Report.new(config, result, errors) }

  let(:now)         { Time.mktime(1970,1,1) }

  before(:all) do
    Time.stub!(:now).and_return(now)
    Meterdata::Report::Metadata::VCS.stub!(:revision).and_return('foo')
    report.add(generator_report)
  end

  it_should_behave_like 'a report where one generator ran'

end

