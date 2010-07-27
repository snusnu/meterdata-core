require 'spec_helper'

require File.expand_path('../../fixtures/generator', __FILE__)

shared_examples_for 'a generator run' do

  its(:raw_output)      { should == 'raw output'      }
  its(:analyzed_output) { should == 'analyzed output' }
  its(:report)          { should == 'report'          }

  its(:hook_recorder) {
    should == %w[
      before_emit
      after_emit
      before_analyze
      after_analyze
      before_generate
      after_generate
    ]
  }

end
