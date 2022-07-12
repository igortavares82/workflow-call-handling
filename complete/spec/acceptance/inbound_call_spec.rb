require 'acceptance_spec_helper'

RSpec.describe 'Inbound call received' do
  When { post(inbound_call_path) }
  Then { expect(last_response.status).to be 200 }
  And  { expect(last_response.headers).to include('Content-Type' => 'application/xml') }
  And  { expect(parsed_response['Response']).to be }
  And  { expect(parsed_response['Response']['Say']).to be }
  And  { expect(parsed_response['Response']['Say']).to eq('Welcome to Maria Flowershop contact center') }
  And  { expect(parsed_response['Response']['Redirect']).to be }
  And  { expect(parsed_response['Response']['Redirect']).to eq('main_menu') }
end
