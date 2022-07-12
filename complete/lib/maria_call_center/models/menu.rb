module MariaCallCenter
  module Models
    class Menu
      attr_reader :messages

      def initialize(messages: )
        @messages = messages
      end
    end
  end
end
