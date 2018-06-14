require 'test_helper'

class OptionValuesControllerTest < ActionController::TestCase
  setup do
    @option_value = option_values(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:option_values)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create option_value" do
    assert_difference('OptionValue.count') do
      post :create, option_value: {  }
    end

    assert_redirected_to option_value_path(assigns(:option_value))
  end

  test "should show option_value" do
    get :show, id: @option_value
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @option_value
    assert_response :success
  end

  test "should update option_value" do
    patch :update, id: @option_value, option_value: {  }
    assert_redirected_to option_value_path(assigns(:option_value))
  end

  test "should destroy option_value" do
    assert_difference('OptionValue.count', -1) do
      delete :destroy, id: @option_value
    end

    assert_redirected_to option_values_path
  end
end
