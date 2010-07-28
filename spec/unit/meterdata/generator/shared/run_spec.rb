require 'spec_helper'

shared_examples_for 'a successful generator run' do

  let(:expected_result) { %w[before_generate generate after_generate] }
  let(:expected_errors) { [] }

  it { should be_kind_of(Meterdata::Generator::Report) }

  it { should respond_to(:config) }
  it { should respond_to(:result) }
  it { should respond_to(:errors) }

  its(:config) { should == config          }
  its(:result) { should == expected_result }
  its(:errors) { should == expected_errors }

end
