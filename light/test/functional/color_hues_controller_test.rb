require 'test_helper'

class ColorHuesControllerTest < ActionController::TestCase
  setup do
    @color_hue = color_hues(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:color_hues)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create color_hue" do
    assert_difference('ColorHue.count') do
      post :create, color_hue: @color_hue.attributes
    end

    assert_redirected_to color_hue_path(assigns(:color_hue))
  end

  test "should show color_hue" do
    get :show, id: @color_hue.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @color_hue.to_param
    assert_response :success
  end

  test "should update color_hue" do
    put :update, id: @color_hue.to_param, color_hue: @color_hue.attributes
    assert_redirected_to color_hue_path(assigns(:color_hue))
  end

  test "should destroy color_hue" do
    assert_difference('ColorHue.count', -1) do
      delete :destroy, id: @color_hue.to_param
    end

    assert_redirected_to color_hues_path
  end
end
