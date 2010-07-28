require 'spec_helper'

require 'meterdata-core/publisher'

require File.expand_path('../../fixtures/publisher', __FILE__)
require File.expand_path('../../shared/run_spec', __FILE__)

describe 'Meterdata::Publisher.publish' do

  subject { Meterdata::Publisher.publish(config, report) }

  it_should_behave_like 'a successful publishing'

end
