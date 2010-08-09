require 'spec_helper'

shared_examples_for 'every publishing run' do

  let(:expected_result) { %w[before_publish publish after_publish] }
  let(:expected_errors) { [] }

  it { should respond_to(:result) }

  its(:result) { should == expected_result }
  its(:errors) { should == expected_errors }

end

shared_examples_for 'a successful publishing' do

  it_should_behave_like 'every publishing run'

  it { should be_published }

end

shared_examples_for 'a failing publishing' do

  it { should_not be_published }

end
