require 'spec_helper'

require 'meterdata/report'

describe 'Meterdata::Report::Metadata#runtime' do

  subject { metadata.runtime }

  let(:metadata) { Meterdata::Report::Metadata.new }

  it { should == {
    'RUBY_COPYRIGHT'    => RUBY_COPYRIGHT,
    'RUBY_DESCRIPTION'  => RUBY_DESCRIPTION,
    'RUBY_ENGINE'       => RUBY_ENGINE,
    'RUBY_PLATFORM'     => RUBY_PLATFORM,
    'RUBY_RELEASE_DATE' => RUBY_RELEASE_DATE,
    'RUBY_VERSION'      => RUBY_VERSION,
    'RUBY_PATCHLEVEL'   => RUBY_PATCHLEVEL,
  }}

end
