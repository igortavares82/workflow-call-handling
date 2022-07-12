require 'twilio-ruby'

module MariaCallCenter
  module Serializers
    class Menu

      def serialize(menu:, success_handler:, timeout_handler: nil)
        ::Twilio::TwiML::VoiceResponse.new do |r|
          r.gather(action: success_handler.to_s,
                   method: 'POST',
                   num_digits: 1) do |gather|
            # TODO add instruction to say the list of messages.
          end
          r.redirect(timeout_handler.to_s) if timeout_handler
        end
      end
    end
  end
end
