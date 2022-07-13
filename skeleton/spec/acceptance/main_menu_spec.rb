require 'acceptance_spec_helper'

RSpec.describe 'Main menu requested' do
  let(:messages) {
   'Mark one for automatic answers. Mark two to speak with an agent'
  }

  When { post(main_menu_path) }
  Then { expect(last_response.status).to be 200 }
  And  { expect(last_response.headers).to include('Content-Type' => 'application/xml') }
  And  { expect(parsed_response['Response']).to be }
  And  { expect(parsed_response['Response']['Gather']).to be }
  And  { expect(parsed_response.dig('Response', 'Gather', 'Say')).to eq(messages) }
  And  { expect(parsed_response['Response']['Redirect']).to be }
  And  { expect(parsed_response['Response']['Redirect']).to eq('main_menu') }
end
