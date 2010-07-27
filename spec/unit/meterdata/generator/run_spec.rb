require 'spec_helper'

require 'spec/unit/meterdata/generator/shared/run_spec'

describe 'Meterdata::Generator#run' do

  subject { generator.run }

  let(:generator) { Meterdata::Specs::Generator.new({}) }

  it_should_behave_like 'a generator run'

end
