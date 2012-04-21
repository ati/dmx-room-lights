require 'test_helper'

class ColorSaturationsControllerTest < ActionController::TestCase
  setup do
    @color_saturation = color_saturations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:color_saturations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create color_saturation" do
    assert_difference('ColorSaturation.count') do
      post :create, color_saturation: @color_saturation.attributes
    end

    assert_redirected_to color_saturation_path(assigns(:color_saturation))
  end

  test "should show color_saturation" do
    get :show, id: @color_saturation.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @color_saturation.to_param
    assert_response :success
  end

  test "should update color_saturation" do
    put :update, id: @color_saturation.to_param, color_saturation: @color_saturation.attributes
    assert_redirected_to color_saturation_path(assigns(:color_saturation))
  end

  test "should destroy color_saturation" do
    assert_difference('ColorSaturation.count', -1) do
      delete :destroy, id: @color_saturation.to_param
    end

    assert_redirected_to color_saturations_path
  end
end
