require_relative 'config/boot'

# Allow CORS when in a local environment to enable API exploration with the Swagger UI
if ENV['RACK_ENV'] == 'development'
  require 'rack/cors'

  use Rack::Cors do
    allow do
      origins '*'
      resource '*', headers: :any, methods: :any
    end
  end
end

use Bugsnag::Rack

use MariaCallCenter::Rack::EnforceHttpsMiddleware

run MariaCallCenter::Web
