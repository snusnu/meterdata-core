require 'spec_helper'

# Expects 'config' to be present
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

shared_examples_for 'a failing generator run' do

  specify do
    expect { subject }.to raise_error(RuntimeError, 'Something bad happened')
  end

end

shared_examples_for "a generator that couldn't be found" do

  specify do
    msg = "The '#{name}' generator could not be found in the Meterdata::Generator class"
    expect { subject }.to raise_error(Meterdata::Generator::UnsupportedGenerator, msg)
  end

end

shared_examples_for 'a broken generator run' do

  specify do
    msg = "Meterdata::Generator::BrokenTest#generate must be implemented"
    expect { subject }.to raise_error(NotImplementedError, msg)
  end

end

