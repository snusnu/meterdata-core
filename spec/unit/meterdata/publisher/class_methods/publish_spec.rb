require 'spec_helper'

require 'meterdata-core/publisher'

require File.expand_path('../../shared/run_spec', __FILE__)

describe 'Meterdata::Publisher.publish' do

  let(:config) {
    Meterdata::Configuration::Publisher.new({
      'version'      => '0.0.1',
      'name'         => name,
      'require_path' => require_path,
    })
  }

  let(:report) { {} }

  subject { Meterdata::Publisher.publish(config, report) }

  context 'when successful' do

    let(:name)         { 'SuccessfulTest'  }
    let(:require_path) { File.expand_path('../../fixtures/successful_publisher', __FILE__) }

    it_should_behave_like 'a successful publishing'

  end

  context 'when failing' do

    let(:name)         { 'FailingTest'  }
    let(:require_path) { File.expand_path('../../fixtures/failing_publisher', __FILE__) }

    it_should_behave_like 'a failing publishing'

  end
end
