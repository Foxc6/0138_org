require 'rails_helper'
require 'spec_helper'

  describe Api::RegimenApp::V1::ConfigController do

    key = ApiKey.first
    headers = {
          "HTTP_ACCEPT": "application/json",
          "X-Application-Authentication-Token": key.access_token,
          "X-Locale": "uk"
        }
    describe "GET /api/regimen-app/config", type: :request do
      before(:each) do
        get  api_regimen_app_config_index_path, nil, headers
      end

      it "makes a connection" do
        expect(response).to be_success
      end

      it "renders the index template" do
        expect(response).to render_template("index")
      end

      it "returns age ranges" do
        test = JSON.parse(response.body)
        expect(test["response"]["data"]["age_ranges"]).not_to be_empty
      end

      it "returns skin types" do
        test = JSON.parse(response.body)
        expect(test["response"]["data"]["skin_types"]).not_to be_empty
      end

      it "returns benefits" do
        test = JSON.parse(response.body)
        expect(test["response"]["data"]["benefits"]).not_to be_empty
      end

      it "returns categories" do
        test = JSON.parse(response.body)
        expect(test["response"]["data"]["categories"]).not_to be_empty
      end

      it "returns regimens" do
        test = JSON.parse(response.body)
        expect(test["response"]["data"]["regimens"]).not_to be_empty
      end

      it "returns genders" do
        test = JSON.parse(response.body)
        expect(test["response"]["data"]["genders"]).not_to be_empty
      end

    end

    describe "GET api/regimen-app/categories", type: :request do
      before(:each) do
        get  api_regimen_app_categories_path, nil, headers
      end
      it "returns makes a connection" do
        expect(response).to be_success
      end

      it "returns categories data" do
        test = JSON.parse(response.body)
        expect(test["response"]["data"]).not_to be_empty
      end

      it "renders categories template" do
        expect(response).to render_template("categories")
      end
    end

    describe "GET api/regimen-app/locales", type: :request do
      before(:each) do
        get  api_regimen_app_locales_path, nil, headers
      end
      it "makes a connection" do
        expect(response).to be_success
      end

      it "returns locales" do
        test = JSON.parse(response.body)
        expect(test["response"]["data"]).not_to be_empty
      end

      it "renders get_locales template" do
        expect(response).to render_template("get_locales")
      end

       it "only returns active locales" do
          test = JSON.parse(response.body)
          test["response"]["data"].each do |x|
            locale = Locale.find_by(code: x["code"])
            expect(locale.active?).to eq(true)
          end
      end
    end

end
