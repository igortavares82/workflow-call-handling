module MariaCallCenter
  module Helpers
    module Log
      include MariaCallCenter::Log
      extend Grape::API::Helpers

      def setup_logger_request_metadata
        logger_context[:platform_tid] = request['talkdesk.platform_tid']
        logger_context[:request_id]   = request['talkdesk.request_id']
        logger_context[:client_ip]    = request['talkdesk.client_ip']
        logger_context[:account_id]   = request['talkdesk.account_id']
        logger_context[:user_id]      = request['talkdesk.user_id']
      end
    end
  end
end
