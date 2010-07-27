require 'spec_helper'

require 'spec/unit/meterdata/generator/shared/run_spec'

describe 'Meterdata::Generator#run' do

  subject { Meterdata::Generator.run(generator, options) }

  let(:generator) { 'Meterdata::Specs::Generator' }
  let(:options)   {             {}              }

  it_should_behave_like 'a generator run'

end
