require 'integration_spec_helper'

require 'rack/test'
require 'rspec/given'
require 'rspec'
require 'dry/container/stub'

require 'support/api'

RSpec.configure do |conf|
  conf.include Rack::Test::Methods
  conf.include MariaCallCenter::Support::API
  conf.include GrapeRouteHelpers::NamedRouteMatcher

  environment = MariaCallCenter::System
  environment.enable_stubs!
end

def app
  MariaCallCenter::Web
end
