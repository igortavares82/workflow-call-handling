require 'twilio-ruby'

module MariaCallCenter
  module Serializers
    class Dial

      def serialize(dial:)
        ::Twilio::TwiML::VoiceResponse.new do |r|
          r.dial do |d|
            d.number(dial.external_number)
          end
        end
      end
    end
  end
end
