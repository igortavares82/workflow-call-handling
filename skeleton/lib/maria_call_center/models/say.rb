module MariaCallCenter
  module Models
    class Say
      attr_reader :message

      def initialize(message:)
        @message = message
      end
    end
  end
end
