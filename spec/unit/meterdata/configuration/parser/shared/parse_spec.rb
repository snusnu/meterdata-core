require 'spec_helper'

require 'meterdata-core/configuration'

require File.expand_path('../../fixtures/broken_parser', __FILE__)

shared_examples_for 'a non compliant configuration parser' do

  let(:path)   { File.expand_path('../fixtures/meterdata.yml', __FILE__) }
  let(:parser) { Meterdata::Specs::Configuration::Parser::BrokenParser.new(path) }

  specify do
    error_msg = "#{parser.class}#load must be implemented"
    expect { subject }.to raise_error(NotImplementedError, error_msg)
  end

end

shared_examples_for 'a compliant configuration parser' do

  let(:parser) { Meterdata::Configuration::Parser.new(path) }

  context 'when parsing a .yml file' do

    let(:path)   { File.expand_path('../../fixtures/meterdata.yml', __FILE__) }

    it_should_behave_like 'a configuration parser parsing a valid configuration'

  end

  context 'when parsing a .json file' do

    let(:path)   { File.expand_path('../../fixtures/meterdata.json', __FILE__) }

    it_should_behave_like 'a configuration parser parsing a valid configuration'

  end

  context 'when attempting to parse a non existing .json file' do

    let(:path) { File.expand_path('../../fixtures/foo.json', __FILE__) }

    specify do
      error_msg = "No config file found at #{path}"
      expect { subject }.to raise_error(Meterdata::Configuration::MissingConfigFileError, error_msg)
    end

  end

  context 'when attempting to parse a non existing .yml file' do

    let(:path) { File.expand_path('../../fixtures/foo.yml', __FILE__) }

    specify do
      error_msg = "No config file found at #{path}"
      expect { subject }.to raise_error(Meterdata::Configuration::MissingConfigFileError, error_msg)
    end

  end

end

shared_examples_for 'a configuration parser parsing a valid configuration' do

  let(:generator)    { subject.generators.first }

  let(:name)         { generator.name           }
  let(:require_path) { generator.require_path   }
  let(:options)      { generator.options        }

  it { should be_kind_of(Meterdata::Configuration) }

  its(:generators) { should respond_to(:each) }

  it 'should only include instances of Meterdata::Configuration::Generator' do
    subject.generators.all? { |g| g.kind_of?(Meterdata::Configuration::Generator) }.should be_true
  end

  it 'should include exactly one generator configuration' do
    subject.generators.size.should == 1
  end

  it "should properly recognize a generator's name" do
    name.should == 'Meterdata::Specs::Generator'
  end

  it "should properly recognize a generator's require_path" do
    require_path.should == Meterdata::Specs.root.join('unit/meterdata/generator/fixtures/generator').to_s
  end

  it "should properly recognize a generator's options" do
    options.should == {}
  end

end
