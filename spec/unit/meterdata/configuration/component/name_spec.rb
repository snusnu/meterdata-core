require 'spec_helper'

shared_examples_for 'Meterdata::Configuration::Component#name' do

  it { should == name }

end
