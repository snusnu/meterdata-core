require 'spec_helper'

shared_examples_for 'Meterdata::Configuration::Component#initialize' do

  let(:version)      { nil }
  let(:name)         { nil }
  let(:require_path) { nil }
  let(:options)      { nil }

  let(:config) {{
    'version'      => version,
    'name'         => name,
    'require_path' => require_path,
    'options'      => options,
  }}

  context 'when all required keys are present' do

    let(:version)      { '0.0.1' }
    let(:name)         {  'foo'  }
    let(:require_path) {  'foo'  }

    specify { expect { subject }.to_not raise_error(Meterdata::Configuration::Generator::IncompleteError) }

  end

  context 'when the version key is missing' do

    let(:name)         { 'foo' }
    let(:require_path) { 'foo' }

    specify do
      msg = "The following #{component_name} key(s) are missing: version"
      expect { subject }.to raise_error(Meterdata::Configuration::Generator::IncompleteError, msg)
    end

  end

  context 'when the name key is missing' do

    let(:version)      { '0.0.1' }
    let(:require_path) {  'foo'  }

    specify do
      msg = "The following #{component_name} key(s) are missing: name"
      expect { subject }.to raise_error(Meterdata::Configuration::Generator::IncompleteError, msg)
    end

  end

  context 'when the require_path key is missing' do

    let(:version)      { '0.0.1' }
    let(:name)         {  'foo'  }

    specify do
      msg = "The following #{component_name} key(s) are missing: require_path"
      expect { subject }.to raise_error(Meterdata::Configuration::Generator::IncompleteError, msg)
    end

  end

  context 'when both the version and the name keys are missing' do

    let(:require_path) { 'foo' }

    specify do
      msg = "The following #{component_name} key(s) are missing: version, name"
      expect { subject }.to raise_error(Meterdata::Configuration::Generator::IncompleteError, msg)
    end

  end

  context 'when both the version and the require_path keys are missing' do

    let(:name)         { 'foo' }

    specify do
      msg = "The following #{component_name} key(s) are missing: version, require_path"
      expect { subject }.to raise_error(Meterdata::Configuration::Generator::IncompleteError, msg)
    end

  end

  context 'when both the name and the require_path keys are missing' do

    let(:version)      { '0.0.1' }

    specify do
      msg = "The following #{component_name} key(s) are missing: name, require_path"
      expect { subject }.to raise_error(Meterdata::Configuration::Generator::IncompleteError, msg)
    end

  end

  context 'when all required keys are missing' do

    specify do
      msg = "The following #{component_name} key(s) are missing: version, name, require_path"
      expect { subject }.to raise_error(Meterdata::Configuration::Generator::IncompleteError, msg)
    end

  end

  context 'when no options are given' do

    let(:version)      { '0.0.1' }
    let(:name)         { 'foo'   }
    let(:require_path) { 'foo'   }

    its(:options) { should == {} }

  end

  context 'when options are given' do

    let(:version)      {    '0.0.1'   }
    let(:name)         {    'foo'     }
    let(:require_path) {    'foo'     }
    let(:options)      { {'a' => 'b'} }

    its(:options) { should == options }

  end

end
