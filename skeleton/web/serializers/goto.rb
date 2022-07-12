require 'twilio-ruby'

module MariaCallCenter
  module Serializers
    class Goto

      def serialize(next_step:)
        ::Twilio::TwiML::VoiceResponse.new do |r|
          r.redirect(next_step.to_s)
        end
      end
    end
  end
end
