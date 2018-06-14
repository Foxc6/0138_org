require 'rails_helper'
require 'spec_helper'

  describe Api::RegimenApp::V1::GuidesController do
    describe "POST /api/regimen-app/guides/login", type: :request do
      guide = FactoryGirl.create(:guide)
      vaild_user = guide.username
      invalid_user = "invalid"
      key = ApiKey.first
      headers = {
            "HTTP_ACCEPT": "application/json",
            "X-Application-Authentication-Token": key.access_token,
            "X-Locale": "na"
          }
      it "Access Token should be returned when user logs in" do
        params = {
          username: vaild_user
        }

        post "/api/regimen-app/guides/login",params, headers
        expect(response).to be_success
        expect(response).to render_template("login")
      end

      it "Should return error when username not found" do
        params = {
          username: invalid_user
        }

        post "/api/regimen-app/guides/login",params, headers
        @expected = {"response"=>{"status"=>"error", "message"=>"Guide not found."}}
        expect(response).to render_template("login")
        expect(JSON.parse(response.body)).to eq @expected
      end
  end
end
