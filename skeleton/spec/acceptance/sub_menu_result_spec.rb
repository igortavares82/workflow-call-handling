require 'acceptance_spec_helper'

RSpec.describe 'Sub menu result' do
  context 'when no option is given' do
    When { post(sub_menu_result_path) }
    Then { expect(last_response.status).to be 400 }
  end

  context 'when option 1 is provided' do
    When { post(sub_menu_result_path, { 'Digits' => '1'}) }
    Then { expect(last_response.status).to be 200 }
    And  { expect(last_response.headers).to include('Content-Type' => 'application/xml') }
    And  { expect(parsed_response['Response']).to be }
    And  { expect(parsed_response['Response']['Redirect']).to be }
    And  { expect(parsed_response['Response']['Redirect']).to eq('request_tax_number') }
  end

  context 'when option 2 is provided' do
    When { post(sub_menu_result_path, { 'Digits' => '2'}) }
    Then { expect(last_response.status).to be 200 }
    And  { expect(last_response.headers).to include('Content-Type' => 'application/xml') }
    And  { expect(parsed_response['Response']).to be }
    And  { expect(parsed_response['Response']['Redirect']).to be }
    And  { expect(parsed_response['Response']['Redirect']).to eq('orders_message') }
  end

  context 'when unsuported option is provided' do
    ['0', '3', '4', '5', '6', '7', '8', '9', '*', '#'].each do |digit|
      When { post(sub_menu_result_path, { 'Digits' => digit}) }
      Then { expect(last_response.status).to be 200 }
      And  { expect(last_response.headers).to include('Content-Type' => 'application/xml') }
      And  { expect(parsed_response['Response']).to be }
      And  { expect(parsed_response['Response']['Redirect']).to be }
      And  { expect(parsed_response['Response']['Redirect']).to eq('voicemail') }
    end
  end
end
