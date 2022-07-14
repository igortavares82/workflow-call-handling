module MariaCallCenter
  module Models
    class Agent
      attr_reader :id
      attr_reader :name
      attr_reader :number
      attr_reader :call_sid

      def initialize(id:, name:, number:, call_sid:)
        @id = id
        @name = name
        @number = number
        @call_sid = call_sid
      end
    end
  end
end
