require 'rails_helper'

RSpec.describe ProductCategoriesController, :type => :controller do
  it "has 200 status code" do
    get :index
    expect(response.status).to eq(200)
  end

  it "should get new" do
    get :new
    expect(assigns(:product_category)).to be_a_new(ProductCategory)
  end

  it "creates a new product_category" do
    expect{
      post :create, product_category: FactoryGirl.attributes_for(:product_category)
    }.to change(ProductCategory,:count).by(1)
  end

  it "should assign local after create" do
    post :create, product_category: FactoryGirl.attributes_for(:product_category)
    @product_category = ProductCategory.last
    expect(@product_category.locale_id).to be
  end

  it "redirects to product categories after create" do
    post :create, product_category: FactoryGirl.attributes_for(:product_category)
    expect(response).to redirect_to product_categories_path
  end

  it "should show product_category" do
    @product_category = ProductCategory.first
    get :show, id: @product_category
    assert_response :success
  end

  it "should get edit" do
    @product_category = ProductCategory.first
    get :edit, id: @product_category
    assert_response :success
  end

  it "should update product_category" do
    @product_category = ProductCategory.first
    patch :update, id: @product_category, product_category: {name: 'Test Update'}
    assert_redirected_to product_categories_path
  end

  it "should destroy product_category" do
    @product_category = ProductCategory.first
    expect{
      delete :destroy, id: @product_category
    }.to change(ProductCategory, :count).by(-1)
    assert_redirected_to product_categories_path
  end
end
