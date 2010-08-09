require 'spec_helper'

require File.expand_path('../../fixtures/successful_generator', __FILE__)
require File.expand_path('../../shared/run_spec', __FILE__)

describe 'Meterdata::Generator.generate' do

  subject { Meterdata::Generator.generate(config) }

  let(:config) {
    Meterdata::Configuration::Generator.new({
      'version'      => '0.0.1',
      'name'         => name,
      'require_path' => require_path,
    })
  }

  context 'when successful' do

    let(:name)         { 'SuccessfulTest'  }
    let(:require_path) { File.expand_path('../fixtures/successful_generator', __FILE__) }

    it_should_behave_like 'a successful generator run'

  end

  context 'when failing' do

    let(:name)         { 'FailingTest'  }
    let(:require_path) { File.expand_path('../fixtures/failing_generator', __FILE__) }

    it_should_behave_like 'a failing generator run'

  end

  context 'when not found' do

    let(:name)         { 'Foo'  }
    let(:require_path) { File.expand_path('../fixtures/broken_generator', __FILE__) }

    it_should_behave_like "a generator that couldn't be found"

  end

  context 'when broken' do

    let(:name)         { 'BrokenTest'  }
    let(:require_path) { File.expand_path('../fixtures/broken_generator', __FILE__) }

    it_should_behave_like 'a broken generator run'

  end

end
