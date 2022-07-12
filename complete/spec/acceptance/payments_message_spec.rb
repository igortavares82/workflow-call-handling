require 'acceptance_spec_helper'

RSpec.describe 'Play payments support message' do
  context 'when no tax number is supplied' do
    When { post(payments_message_path) }
    Then { expect(last_response.status).to be 400 }
  end

  context 'when tax number is supplied' do
    let(:message) {
      'Check your payment records on www dot mariaflowershop dot com slash payments slash 123456789'
    }

    When { post(payments_message_path, {'Digits' => '123456789'}) }
    Then { expect(last_response.status).to be 200 }
    And  { expect(last_response.headers).to include('Content-Type' => 'application/xml') }
    And  { expect(parsed_response['Response']).to be }
    And  { expect(parsed_response['Response']['Say']).to be }
    And  { expect(parsed_response['Response']['Say']).to eq(message) }
    And  { expect(parsed_response['Response']['Redirect']).not_to be }
  end
end
