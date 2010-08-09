require 'spec_helper'

require 'meterdata-core/publisher'

require File.expand_path('../shared/run_spec', __FILE__)

require File.expand_path('../fixtures/successful_publisher', __FILE__)
require File.expand_path('../fixtures/failing_publisher', __FILE__)

describe 'Meterdata::Publisher#run' do

  let(:report) { {} }

  let(:config) {
    Meterdata::Configuration::Publisher.new({
      'version'      => '0.0.1',
      'name'         => name,
      'require_path' => require_path,
    })
  }

  let(:publisher) { Meterdata::Publisher.new(config, report) }

  context 'when successful' do

    subject { publisher.run }

    let(:name)         { 'SuccessfulTest'  }
    let(:require_path) { File.expand_path('../fixtures/successful_publisher', __FILE__) }

    it_should_behave_like 'a successful publishing'

  end

  context 'when failing' do
    subject { publisher.run }

    let(:name)         { 'FailingTest'  }
    let(:require_path) { File.expand_path('../fixtures/failing_publisher', __FILE__) }

    it_should_behave_like 'a failing publishing'
  end

end

