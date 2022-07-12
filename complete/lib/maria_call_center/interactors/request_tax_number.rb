require 'maria_call_center/log'
require 'maria_call_center/models/input'

module MariaCallCenter
  module Interactors
    class RequestTaxNumber
      include Log

      def initialize(_environment)
        @message = 'Please insert your tax number'.freeze
      end

      def call
        Models::Input.new(message: @message, length: 9)
      end
    end
  end
end
