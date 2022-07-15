require 'mongo'
require 'maria_call_center/log'
require 'maria_call_center/models/agent'

module MariaCallCenter
  module Repository
    class AgentRepository
      include Log

      def initialize
        @client = Mongo::Client.new(ENV["MONGO_URL"], auth_source: 'admin')
      end

      def create(agent:)
        @client[:agents].insert_one({
          id: agent.id,
          name: agent.name,
          number: agent.number,
          call_sid: agent.call_sid })
      end

      def get(call_sid:)
        @client[:agents].find({ call_sid: call_sid }).limit(1).each { |doc|
          @agent= MariaCallCenter::Models::Agent.new(
            id: doc['id'],
            name: doc['name'],
            number: doc['number'],
            call_sid: doc['call_sid'])
        }
        @agent
      end

      def delete(agent:)
        @client[:agents].delete_one(call_sid: agent.call_sid)
      end
    end
  end
end
