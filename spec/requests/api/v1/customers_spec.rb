require 'rails_helper'
require 'spec_helper'
require 'database_cleaner'


  describe Api::RegimenApp::V1::CustomersController do
    customer = Customer.find_by(email: "test@gmail.com")
    if customer
    else
      customer = Customer.create!(email: "test@gmail.com", locale_id: 1)
    end
    key = ApiKey.first
    headers = {
          "HTTP_ACCEPT": "application/json",
          "X-Application-Authentication-Token": key.access_token,
          "X-Locale": "na"
        }
    describe "GET /api/regimen-app/customers?#{customer.email}", type: :request do
      it "returns customer" do

        params = {
          "email": "#{customer.email}"
        }
        get  api_regimen_app_customers_path(params), nil, headers
        expect(response).to be_success
      end

      it "returns error with no customer email" do

        get  api_regimen_app_customers_path, nil, headers
        @expected = {"response"=> {"status"=> "error","message"=> "Customer not found."}}
        expect(JSON.parse(response.body)).to eq @expected
      end

      it "assigns locale after create" do
        cust = FactoryGirl.create(:customer)
        expect(cust).to be_instance_of(Customer)
      end

      # it "validates email" do
      #   cust = FactoryGirl.build(:customer, :email=>"")
      #   expect(cust).to_not be_valid
      # end
  end


end
