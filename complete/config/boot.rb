$LOAD_PATH << File.join(File.dirname(__FILE__), '..', 'web')
$LOAD_PATH << File.join(File.dirname(__FILE__), '..', 'lib')

ENV['RACK_ENV'] ||= 'development'

require_relative 'log'
require_relative 'multi_json'
require_relative 'bugsnag'

require 'maria_call_center'
require 'maria_call_center/log'
require 'web'
require 'rack/enforce_https_middleware'
require 'pry' if ENV['RACK_ENV'] == 'development'

module MariaCallCenter
  System = MariaCallCenter.dependencies(eagerly_initialize: !['development', 'test'].include?(ENV['RACK_ENV']))
end

# Load newrelic after all other gems and files, to make sure all probes are
# enabled (otherwise some conditional probes may not load).
require_relative 'newrelic'
