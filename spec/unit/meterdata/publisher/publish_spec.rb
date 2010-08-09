require 'spec_helper'

require 'meterdata-core/publisher'

require File.expand_path('../fixtures/successful_publisher', __FILE__)
require File.expand_path('../fixtures/failing_publisher', __FILE__)
require File.expand_path('../fixtures/broken_publisher', __FILE__)

describe 'Meterdata::Publisher#published?' do

  subject { publisher.publish }

  let(:publisher) { Meterdata::Publisher.new(config, report) }

  let(:report) { {} }

  let(:config) {
    Meterdata::Configuration::Publisher.new({
      'version'      => '0.0.1',
      'name'         => name,
      'require_path' => require_path,
    })
  }

  context 'with a successful publisher' do

    let(:name)         { 'SuccessfulTest' }
    let(:require_path) { File.expand_path('../fixtures/successful_publisher', __FILE__) }

    it { should be_true }

  end

  context 'with a failing publisher' do

    let(:name)         { 'FailingTest' }
    let(:require_path) { File.expand_path('../fixtures/failing_publisher', __FILE__) }

    it { should be_false }

  end

  context 'with a broken publisher' do

    let(:name)         { 'BrokenTest' }
    let(:require_path) { File.expand_path('../fixtures/broken_publisher', __FILE__) }

    specify do
      msg = "Meterdata::Publisher::BrokenTest#publish must be implemented"
      expect { subject }.to raise_error(NotImplementedError, msg)
    end

  end

end

