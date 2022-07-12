require 'acceptance_spec_helper'

RSpec.describe 'Sub menu requested' do
  let(:messages) {
    'Mark one for payments. Mark two for orders. Mark any other key to leave a message'
  }

  When { post(sub_menu_path) }
  Then { expect(last_response.status).to be 200 }
  And  { expect(last_response.headers).to include('Content-Type' => 'application/xml') }
  And  { expect(parsed_response['Response']).to be }
  And  { expect(parsed_response['Response']['Gather']).to be }
  And  { expect(parsed_response.dig('Response', 'Gather', 'Say')).to eq(messages) }
  And  { expect(parsed_response['Response']['Redirect']).not_to be }
end
