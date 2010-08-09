require 'spec_helper'

shared_examples_for 'Meterdata::Configuration::Component#version' do

  it { should == version }

end
