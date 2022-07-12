require 'acceptance_spec_helper'

RSpec.describe 'Leave message' do
  let(:message) {
    'Please leave a message after the beep'
  }

  When { post(voicemail_path) }
  Then { expect(last_response.status).to be 200 }
  And  { expect(last_response.headers).to include('Content-Type' => 'application/xml') }
  And  { expect(parsed_response['Response']).to be }
  And  { expect(parsed_response['Response']['Say']).to be }
  And  { expect(parsed_response['Response']['Say']).to eq(message) }
  And  { expect(parsed_response['Response']['Record']).to be }
  And  { expect(parsed_response['Response']['Hangup']).to be }
  And  { expect(parsed_response['Response']['Redirect']).not_to be }
end
