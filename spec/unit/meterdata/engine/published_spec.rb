require 'spec_helper'

require 'meterdata-core/engine'

describe 'Meterdata::Engine#published?' do

  subject { engine.published? }

  let(:path)          { File.expand_path('../fixtures/valid_meterdata.yml', __FILE__) }
  let(:configuration) { Meterdata::Configuration.load(path)                     }

  context "when the engine hasn't finished running yet" do

    let(:engine) { Meterdata::Engine.new(configuration) }

    it { should == false }

  end

  context "when the engine finished running all generators" do

    let(:engine) { Meterdata::Engine.run(configuration) }

    it { should == true }

  end

end
