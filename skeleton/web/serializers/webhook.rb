require 'twilio-ruby'

module MariaCallCenter
  module Serializers
    class Webhook

      def serialize(message: 'Thank you')
        ::Twilio::TwiML::VoiceResponse.new do |r|
          r.gather() do |gather|
            gather.say(message: message)
        end
      end
    end
  end
end
