require 'spec_helper'

shared_examples_for 'a successful engine run' do

  its(:configuration) { should == configuration }

  it { should be_published }

end

shared_examples_for 'a failed engine run' do

  its(:configuration) { should == configuration }
  its(:report)        { should be_nil           }

  it { should_not be_published }

end
