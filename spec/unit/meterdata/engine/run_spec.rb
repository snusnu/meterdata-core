require 'spec_helper'

require 'meterdata-core/engine'

require 'spec/unit/meterdata/engine/shared/run_spec'

describe 'Meterdata::Engine#run' do

  subject { Meterdata::Engine.new(configuration).run }

  context 'when all configured generators can be found' do

    let(:path)          { File.expand_path('../fixtures/valid_meterdata.yml', __FILE__) }
    let(:configuration) {           Meterdata::Configuration.load(path)           }

    it_should_behave_like 'a successful engine run'

  end

end
