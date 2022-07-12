require 'maria_call_center/log'
require 'maria_call_center/models/menu'

module MariaCallCenter
  module Interactors
    class PresentSubMenu
      include Log

      def initialize(_environment)
        @messages = [
          'Mark one for payments',
          'Mark two for orders',
          'Mark any other key to leave a message',
        ].freeze
      end

      def call
        Models::Menu.new(messages: @messages)
      end
    end
  end
end
