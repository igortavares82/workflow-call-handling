module MariaCallCenter
  module Models
    class Voicemail
      attr_reader :message
      attr_reader :beep
      attr_reader :timeout

      def initialize(beep:, timeout:, message:)
        @message = message
        @beep = beep
        @timeout = timeout
      end
    end
  end
end
