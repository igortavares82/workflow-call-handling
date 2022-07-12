require 'nori'

module MariaCallCenter
  module Support
    module API
      def initialize(*)
        @nori = Nori.new(empty_tag_value: true)
      end

      def parsed_response
        @nori.parse(last_response.body)
      end
    end
  end
end
