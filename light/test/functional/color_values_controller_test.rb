require 'test_helper'

class ColorValuesControllerTest < ActionController::TestCase
  setup do
    @color_value = color_values(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:color_values)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create color_value" do
    assert_difference('ColorValue.count') do
      post :create, color_value: @color_value.attributes
    end

    assert_redirected_to color_value_path(assigns(:color_value))
  end

  test "should show color_value" do
    get :show, id: @color_value.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @color_value.to_param
    assert_response :success
  end

  test "should update color_value" do
    put :update, id: @color_value.to_param, color_value: @color_value.attributes
    assert_redirected_to color_value_path(assigns(:color_value))
  end

  test "should destroy color_value" do
    assert_difference('ColorValue.count', -1) do
      delete :destroy, id: @color_value.to_param
    end

    assert_redirected_to color_values_path
  end
end
