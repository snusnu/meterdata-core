require 'spec_helper'
require 'meterdata'

describe 'Meterdata.working_directory(=)' do

  subject { Meterdata.working_directory }

  context 'when no working_dir was set previously' do
    it { should == Pathname(Dir.pwd) }
  end

  context 'when a working_dir was set previously' do
    before { Meterdata.working_directory = 'foo' }
    it { should == Pathname('foo') }
  end

end

