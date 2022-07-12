require 'twilio-ruby'

module MariaCallCenter
  module Serializers
    class Input

      def serialize(input:, success_handler:, timeout_handler: nil)
        ::Twilio::TwiML::VoiceResponse.new do |r|
          r.gather(action: success_handler.to_s,
                   method: 'POST',
                   num_digits: input.length) do |gather|
            gather.say(message: input.message)
          end

          r.redirect(timeout_handler.to_s) if timeout_handler
        end
      end
    end
  end
end
