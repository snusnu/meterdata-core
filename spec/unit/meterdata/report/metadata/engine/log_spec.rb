require 'spec_helper'

require 'meterdata/report'

describe 'Meterdata::Report::Metadata::Engine#log' do

  subject { Meterdata::Report::Metadata::Engine.new }

  let(:level)   { :info    }
  let(:key)     { :key     }
  let(:message) { :message }

  its(:logs)    { should == {} }

  it 'should store the level as a String' do
    subject.log(level, key, message)
    subject.logs.keys.include?('info')
  end

  it 'should store the key as a String' do
    subject.log(level, key, message)
    subject.logs[level.to_s].keys.include?(key.to_s)
  end

  it 'should store the message as a String' do
    subject.log(level, key, message)
    subject.logs[level.to_s][key.to_s].include?(message.to_s)
  end

  it 'should append messages to the specified level and key' do
    2.times { subject.log(level, key, message) }
    subject.logs[level.to_s][key.to_s].size.should == 2
    subject.logs[level.to_s][key.to_s].all? { |entry| entry == message.to_s }.should be_true
  end

end
