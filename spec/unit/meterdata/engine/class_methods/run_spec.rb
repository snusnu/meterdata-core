require 'spec_helper'

require 'meterdata/engine'

require 'spec/unit/meterdata/engine/shared/run_spec'

describe 'Meterdata::Engine#run' do

  subject { Meterdata::Engine.run(config) }

  context 'when the generator configuration is valid' do

    let(:path)   { File.expand_path('../../fixtures/valid_meterdata.yml', __FILE__) }
    let(:config) {               Meterdata::Configuration.load(path)                }

    it_should_behave_like 'a successful engine run'

  end

  # context 'when generator.require_path does not point to a valid ruby file' do
  #
  #   let(:path)   { File.expand_path('../../fixtures/broken_path_meterdata.yml', __FILE__) }
  #   let(:config) {               Meterdata::Configuration.load(path)                      }
  #
  #   specify do
  #     expected_error_msg = "The 'Foo' generator could not be found at 'foo'"
  #     expect { subject }.to raise_error(LoadError, expected_error_msg)
  #   end
  #
  # end
  #
  # context 'when the generator.name does not match any constant defined in generator.require_path' do
  #
  #   let(:path)   { File.expand_path('../../fixtures/broken_name_meterdata.yml', __FILE__) }
  #   let(:config) {              Meterdata::Configuration.load(path)                       }
  #
  #   specify do
  #     path = Meterdata::Specs.root.join('unit/meterdata/generator/fixtures/generator')
  #     expected_error_msg = "'#{path}' does not define the 'Foo' generator"
  #     expect { subject }.to raise_error(Meterdata::Generator::UnsupportedGenerator, expected_error_msg)
  #   end
  #
  # end

end
