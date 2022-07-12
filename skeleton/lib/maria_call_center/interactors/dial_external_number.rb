require 'maria_call_center/log'
require 'maria_call_center/models/dial'

module MariaCallCenter
  module Interactors
    class DialExternalNumber
      include Log

      def initialize(environment)
        @number = nil # load number from environment
      end

      def call
        Models::Dial.new(external_number: @number)
      end
    end
  end
end
