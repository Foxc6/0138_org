require 'rails_helper'

RSpec.describe ProductsController, :type => :controller do
  before(:each) { @product = Product.first }
  it "has 200 status code" do
    get :index
    expect(response.status).to eq(200)
  end

  context "with valide attributes" do
    it "should get new" do
      get :new
      expect(assigns(:product)).to be_a_new(Product)
    end

    it "creates a new product" do
      expect{
        post :create, product: FactoryGirl.attributes_for(:product)
      }.to change(Product,:count).by(1)
    end

    it "should assign local after create" do
      post :create, product: FactoryGirl.attributes_for(:product)
      @product = Product.last
      expect(@product.locale_id).to be
    end

     it "should set master variant after create" do
      post :create, product: FactoryGirl.attributes_for(:product)
      @product = Product.last
      expect(@product.master).to be
    end

    it "redirects to the new product" do
      post :create, product: FactoryGirl.attributes_for(:product)
      expect(response).to redirect_to Product.last
    end
  end

  context "with invalid attributes" do
    it "does not save the new product" do
      expect{
        post :create, product: FactoryGirl.attributes_for(:product, name: "")
      }.to_not change(Product,:count)
    end

    it "re-renders the new method" do
      post :create,  product: FactoryGirl.attributes_for(:product, name: "")
      expect(response).to render_template :new
    end
  end

  it "should show product" do
    get :show, id: @product
    assert_response :success
  end

  it "should get edit" do
    get :edit, id: @product
    assert_response :success
  end

  it "should update product" do
    patch :update, id: @product, product: {name: 'Test Update'}
    assert_redirected_to product_path(assigns(:product))
  end

  it "should destroy product" do
    expect{
      delete :destroy, id: @product
    }.to change(Product, :count).by(-1)
    assert_redirected_to products_path
  end
end
