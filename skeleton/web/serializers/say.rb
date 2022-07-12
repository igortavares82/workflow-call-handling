require 'twilio-ruby'

module MariaCallCenter
  module Serializers
    class Say

      def serialize(say:, next_step: nil)
        ::Twilio::TwiML::VoiceResponse.new do |r|
          r.say(message: say.message)
          r.redirect(next_step.to_s) if next_step
        end
      end
    end
  end
end
