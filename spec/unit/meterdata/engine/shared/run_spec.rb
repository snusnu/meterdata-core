require 'spec_helper'

shared_examples_for 'a successful engine run' do

  its(:config) { should == config }
  its(:report) { should_not be_nil    }

end

shared_examples_for 'a failed engine run' do

  its(:config) { should == config }
  its(:report) { should be_nil    }

end
