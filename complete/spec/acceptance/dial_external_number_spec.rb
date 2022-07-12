require 'acceptance_spec_helper'

RSpec.describe 'Dial external number' do
  Given {
    MariaCallCenter::System.stub(:env, {'AGENT_NUMBER' => '+123456789'})
  }
  When { post(dial_number_path) }
  Then { expect(last_response.status).to be 200 }
  And  { expect(last_response.headers).to include('Content-Type' => 'application/xml') }
  And  { expect(parsed_response['Response']).to be }
  And  { expect(parsed_response['Response']['Dial']).to be }
  And  { expect(parsed_response.dig('Response', 'Dial', 'Number')).to eq('+123456789') }
  And  { expect(parsed_response['Response']['Redirect']).not_to be }
end
