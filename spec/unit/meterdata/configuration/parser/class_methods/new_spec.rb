require 'spec_helper'

require 'meterdata/configuration'

describe 'Meterdata::Configuration::Parser.new' do

  subject { Meterdata::Configuration::Parser.new(path) }

  context 'when loading the configuration from an existing .yml file' do

    let(:path) { File.expand_path('../../fixtures/meterdata.yml', __FILE__) }

    it { should be_kind_of(Meterdata::Configuration::Parser::YamlParser) }

  end

  context 'when loading the configuration from an existing .json file' do

    let(:path) { File.expand_path('../../fixtures/meterdata.json', __FILE__) }

    it { should be_kind_of(Meterdata::Configuration::Parser::JsonParser) }

  end

  context 'when attempting to load the configuration from a file of unsupported type' do

    let(:path) { File.expand_path('../../fixtures/meterdata.foo', __FILE__) }

    specify do
      error_msg = "'#{path}' is not a supported file type for meterdata config files (use .yml or .json)"
      expect { subject }.to raise_error(Meterdata::Configuration::UnsupportedFormatError, error_msg)
    end

  end

end
