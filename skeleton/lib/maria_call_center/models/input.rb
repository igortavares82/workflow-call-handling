module MariaCallCenter
  module Models
    class Input
      attr_reader :message, :length

      def initialize(message:, length: 1)
        @message = message
        @length = length
      end
    end
  end
end
