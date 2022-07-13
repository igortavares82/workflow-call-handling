require 'maria_call_center/log'
require 'maria_call_center/models/dial'

module MariaCallCenter
  module Interactors
    class DialExternalNumber
      include Log

      def initialize(environment)
        @number = ENV['EXTERNAL_NUMBER'] # load number from environment
      end

      def call

        if ENV['RUBY_ENVIRONMENT'] == 'dev'
          @number = System[:retrieve_agent].call
        end
        
        Models::Dial.new(external_number: @number)
      end
    end
  end
end
