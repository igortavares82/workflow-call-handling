module MariaCallCenter
  module Models
    class Dial
      attr_reader :external_number

      def initialize(external_number:)
        @external_number = external_number
      end
    end
  end
end
