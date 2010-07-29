require 'spec_helper'

shared_examples_for 'Meterdata::Configuration::Component#name' do

  let(:config) {{
    'version'      => '0.0.1',
    'name'         => 'foo',
    'require_path' => 'foo',
  }}

  it { should == 'foo' }

end
