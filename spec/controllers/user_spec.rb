require 'rails_helper'

RSpec.describe UsersController, :type => :controller do
  include Devise::TestHelpers
  before :each do
    @user = User.new
  end

  describe '#new' do
    it "returns a new user object" do
      expect(@user).to be_an_instance_of(User)
    end
  end
end
