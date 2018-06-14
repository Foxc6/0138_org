require 'rails_helper'
RSpec.describe GuidesController, :type => :controller do
key = ENV["MAILCHIMP_API_KEY"]
list = ENV["MAILCHIMP_LIST_ID"]
  before(:each) { @guide = Guide.first }
  it "has 200 status code" do
    get :index
    expect(response.status).to eq(200)
  end

  context "with valid attributes" do
    it "should get new" do
      get :new
      expect(assigns(:guide)).to be_a_new(Guide)
    end

    it "creates a new guide" do
      pending
      guide = FactoryGirl.attributes_for(:guide)
       url = "https://apikey:"+key+".api.mailchimp.com/3.0/lists/"+list+"/members"

        url = URI.encode(url)

        body = {
          email_address: guide[:email],
          status: 'subscribed',
          merge_fields: {
            FNAME: guide[:first_name],
            LNAME: guide[:last_name],
            EMAIL: guide[:email]
            }
          }

       WebMock.stub_request(:post, url).
         with(
          :body => body,
          :headers => {
            'Accept'=>'*/*',
            'Content-Type'=>'application/json',
            'User-Agent'=>'Faraday v0.9.2'
            }
          ).
         to_return(:status => 200, :body => "", :headers => {})

    end

     it "should assign local after create" do
      pending "Implementing api strategy"
        WebMock.stub_request(:post, "https://apikey:"+key+".api.mailchimp.com/3.0/lists/"+list+"/members").
         with(:body => "{\"email_address\":\"german@yahoo.com\",\"status\":\"subscribed\",\"merge_fields\":{\"FNAME\":\"Pat\",\"LNAME\":\"Smith\",\"EMAIL\":\"german@yahoo.com\"}}",
              :headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Content-Type'=>'application/json', 'User-Agent'=>'Faraday v0.9.2'}).
         to_return(:status => 200, :body => "", :headers => {})
      # post :create, guide: FactoryGirl.attributes_for(:guide)
      @guide = Guide.last
      expect(@guide.locale_id).to be
    end

    it "redirects to the new guide" do
      pending "Implementing api strategy"
       WebMock.stub_request(:post, "https://apikey:"+key+".api.mailchimp.com/3.0/lists/"+list+"/members").
         with(:body => "{\"email_address\":\"eve_prosacco@yahoo.com\",\"status\":\"subscribed\",\"merge_fields\":{\"FNAME\":\"Jody\",\"LNAME\":\"Carter\",\"EMAIL\":\"eve_prosacco@yahoo.com\"}}",
              :headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Content-Type'=>'application/json', 'User-Agent'=>'Faraday v0.9.2'}).
         to_return(:status => 200, :body => "", :headers => {})
      # post :create, guide: FactoryGirl.attributes_for(:guide)
      # expect(response).to redirect_to Guide.last
    end
  end

  context "with invalid attributes" do
    it "does not save the new guide" do
      pending
      expect{
        post :create, guide: FactoryGirl.attributes_for(:guide, email: "")
      }.to_not change(Guide,:count)
    end

    it "re-renders the new method" do
      pending
      post :create,  guide: FactoryGirl.attributes_for(:guide, email: "")
      expect(response).to render_template :new
    end
  end

  it "should show guide" do
    get :show, id: @guide
    assert_response :success
  end

  it "should get edit" do
    get :edit, id: @guide
    assert_response :success
  end

  it "should update guide" do
    patch :update, id: @guide, guide: {name: 'Test Update'}
    assert_redirected_to guide_path(assigns(:guide))
  end

  it "should destroy guide" do
    expect{
      delete :destroy, id: @guide
    }.to change(Guide, :count).by(-1)
    assert_redirected_to guides_path
  end
end
