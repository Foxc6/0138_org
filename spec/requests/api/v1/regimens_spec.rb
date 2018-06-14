require 'rails_helper'
require 'spec_helper'

describe Api::RegimenApp::V1::RegimensController do
  key = ApiKey.first
  headers = {
        "HTTP_ACCEPT": "application/json",
        "X-Application-Authentication-Token": key.access_token,
        "X-Locale": "na"
      }

  describe "GET /api/regimen-app/regimens", type: :request do
    it "returns all regimens" do
      get api_regimen_app_regimens_path, nil, headers
      expect(JSON.parse(response.body)["response"]["status"]).to eq "success"
    end
  end


end #<-- controller -->
