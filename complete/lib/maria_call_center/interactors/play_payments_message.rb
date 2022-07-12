require 'maria_call_center/log'
require 'maria_call_center/models/say'

module MariaCallCenter
  module Interactors
    class PlayPaymentsMessage
      include Log

      def initialize(_environment)

      end

      def call(tax_number:)
        Models::Say.new(message: "Check your payment records on www dot mariaflowershop dot com slash payments slash #{tax_number}")
      end
    end
  end
end
