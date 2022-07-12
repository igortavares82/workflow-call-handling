require 'maria_call_center/log'
require 'maria_call_center/models/menu'

module MariaCallCenter
  module Interactors
    class PresentMainMenu
      include Log

      def initialize(_environment)
        @messages = [
          'Mark one for automatic answers',
          'Mark two to speak with an agent',
        ].freeze
      end

      def call
        Models::Menu.new(messages: @messages)
      end
    end
  end
end
