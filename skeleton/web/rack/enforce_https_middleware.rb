require 'multi_json'
require 'bugsnag'

# Rack middleware to throw errors when https is not being used

module MariaCallCenter
  module Rack
    class EnforceHttpsMiddleware
      ENFORCE_HTTPS_USAGE = ENV['RACK_ENV'] != 'development'

      InsecureRequestError = Class.new(StandardError)

      def initialize(app, enforce_https_usage: ENFORCE_HTTPS_USAGE)
        @app = app
        @enforce_https_usage = enforce_https_usage
      end

      def call(env)
        if !@enforce_https_usage || using_https?(env)
          @app.call(env)
        else
          report_issue(env)
          use_https_response(env)
        end
      end

      private

      def using_https?(env)
        protocol(env) == 'https'
      end

      def protocol(env)
        env['HTTP_X_FORWARDED_PROTO']
      end

      def use_https_response(env)
        [
          400,
          {'Content-Type' => 'application/hal+json'},
          [MultiJson.dump({error: "Unsupported protocol '#{protocol(env)}', please switch to https"}, pretty: true)],
        ]
      end

      def report_issue(env)
        Bugsnag.notify(InsecureRequestError.new("Request attempted with protocol '#{protocol(env)}'"))
      end
    end
  end
end
