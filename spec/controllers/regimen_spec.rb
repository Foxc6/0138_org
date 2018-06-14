require 'rails_helper'

RSpec.describe RegimensController, :type => :controller do
  before(:each) { @regimen = Regimen.first }
  it "has 200 status code" do
    get :index
    expect(response.status).to eq(200)
  end

  context "with valide attributes" do
    it "should get new" do
      get :new
      expect(assigns(:regimen)).to be_a_new(Regimen)
    end

    it "creates a new regimen" do
      expect{
        post :create, regimen: FactoryGirl.attributes_for(:regimen)
      }.to change(Regimen,:count).by(1)
    end

    it "should assign local after create" do
      post :create, regimen: FactoryGirl.attributes_for(:regimen)
      @regimen = Regimen.last
      expect(@regimen.locale_id).to be
    end

    it "redirects to the new regimen" do
      post :create, regimen: FactoryGirl.attributes_for(:regimen)
      expect(response).to redirect_to Regimen.last
    end
  end

  context "with invalid attributes" do
    it "does not save the new regimen" do
      expect{
        post :create, regimen: FactoryGirl.attributes_for(:regimen, name: "")
      }.to_not change(Regimen,:count)
    end

    it "re-renders the new method" do
      post :create,  regimen: FactoryGirl.attributes_for(:regimen, name: "")
      expect(response).to render_template :new
    end
  end

  it "should show regimen" do
    get :show, id: @regimen
    assert_response :success
  end

  it "should get edit" do
    get :edit, id: @regimen
    assert_response :success
  end

  it "should update regimen" do
    patch :update, id: @regimen, regimen: {name: 'Test Update'}
    assert_redirected_to regimen_path(assigns(:regimen))
  end

  it "should destroy regimen" do
    expect{
      delete :destroy, id: @regimen
    }.to change(Regimen, :count).by(-1)
    assert_redirected_to regimens_path
  end
end
