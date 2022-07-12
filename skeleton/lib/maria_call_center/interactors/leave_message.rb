require 'maria_call_center/log'
require 'maria_call_center/models/voicemail'

module MariaCallCenter
  module Interactors
    class LeaveMessage
      include Log

      def initialize(_environment)

      end

      def call(beep:)
        Models::Voicemail.new(beep: beep, timeout: 5, message: message(!!beep))
      end

      private
      def message(beep)
        # TODO return appropriate message in function of beep value
      end
    end
  end
end
