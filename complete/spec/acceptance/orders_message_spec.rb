require 'acceptance_spec_helper'

RSpec.describe 'Play orders support message' do
  let(:message) {
    'Place orders at www dot mariaflowershop dot com slash orders'
  }
  When { post(orders_message_path) }
  Then { expect(last_response.status).to be 200 }
  And  { expect(last_response.headers).to include('Content-Type' => 'application/xml') }
  And  { expect(parsed_response['Response']).to be }
  And  { expect(parsed_response['Response']['Say']).to be }
  And  { expect(parsed_response['Response']['Say']).to eq(message) }
  And  { expect(parsed_response['Response']['Redirect']).not_to be }
end
