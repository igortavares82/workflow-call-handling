require 'maria_call_center/log'
require 'maria_call_center/models/say'

module MariaCallCenter
  module Interactors
    class PlayOrdersMessage
      include Log

      def initialize(_environment)
        @message = 'Place orders at www dot mariaflowershop dot com slash orders'.freeze
      end

      def call
        Models::Say.new(message: @message)
      end
    end
  end
end
