require 'spec_helper'

require 'meterdata/report'

shared_examples_for "a report where one generator ran" do

  it {

    should ==

    {
      'metadata' => {
        'engine' => {
          'version' => Meterdata::VERSION,
          'log' => {},
        },
        'timestamp' => now.to_i,
        'revision'  => Meterdata::Report::Metadata::VCS.revision,
        'runtime'   => {
          'RUBY_COPYRIGHT'    => RUBY_COPYRIGHT,
          'RUBY_DESCRIPTION'  => RUBY_DESCRIPTION,
          'RUBY_ENGINE'       => RUBY_ENGINE,
          'RUBY_PLATFORM'     => RUBY_PLATFORM,
          'RUBY_RELEASE_DATE' => RUBY_RELEASE_DATE,
          'RUBY_VERSION'      => RUBY_VERSION,
          'RUBY_PATCHLEVEL'   => RUBY_PATCHLEVEL,
        },
      },
      'reports'  => [
        {
          'generator' => {
            'name'    => 'Foo',
            'version' => '0.0.1',
            'options' => { 'foo' => 'bar' },
          },
          'result' => {},
          'errors' => [],
        },
      ],
    }.to_json

  }

end

