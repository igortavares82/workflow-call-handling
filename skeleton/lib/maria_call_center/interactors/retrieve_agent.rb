require 'maria_call_center/log'
require 'maria_call_center/models/agent'
require 'httparty'
require 'json'

module MariaCallCenter
  module Interactors
    class RetrieveAgent
      include Log

      def initialize(environment)
        @agent_manager_url = ENV['AGENT_MANAGER_URL']
      end

      def call(call_sid:)
        response = HTTParty.post("#{@agent_manager_url}/agents/retrieve")
        MariaCallCenter::Models::Agent.new(
          id: response.parsed_response['id'],
          name: response.parsed_response['name'],
          number: response.parsed_response['number'],
          call_sid: call_sid)
      end
    end
  end
end
