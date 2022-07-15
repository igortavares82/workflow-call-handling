require 'maria_call_center/models/agent'
require 'httparty'

module MariaCallCenter
  module Interactors
    class ReleaseAgent

      def initialize(environment)
        @agent_manager_url = ENV['AGENT_MANAGER_URL']
        @repository = MariaCallCenter::Repository::AgentRepository.new
      end

      def call(call_sid:)
        agent = @repository.get(call_sid: call_sid)
        response = HTTParty.post("#{@agent_manager_url}/agents/release/#{agent.id}")
        delete(agent: agent)

        return
      end

      def delete(agent:)
        @repository.delete(agent: agent)

        return
      end
    end
  end
end
