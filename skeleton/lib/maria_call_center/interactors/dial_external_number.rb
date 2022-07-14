require 'maria_call_center/log'
require 'maria_call_center/models/dial'
require 'maria_call_center/repository/agent_repository'

module MariaCallCenter
  module Interactors
    class DialExternalNumber
      include Log

      def initialize(environment)
        @number = ENV['EXTERNAL_NUMBER'] # load number from environment
      end

      def call(call_sid: nil)

        if ENV['RUBY_ENVIRONMENT'] == 'dev'
          @agent = System[:retrieve_agent].call(call_sid: call_sid)
          save(agent: @agent)

          @number = @agent.number
        end

        Models::Dial.new(external_number: @number)
      end

      def save(agent:)
        @repository = MariaCallCenter::Repository::AgentRepository.new
        @repository.create(agent: agent)
      end
    end
  end
end
