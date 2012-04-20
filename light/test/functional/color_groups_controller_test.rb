require 'test_helper'

class ColorGroupsControllerTest < ActionController::TestCase
  setup do
    @color_group = color_groups(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:color_groups)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create color_group" do
    assert_difference('ColorGroup.count') do
      post :create, color_group: @color_group.attributes
    end

    assert_redirected_to color_group_path(assigns(:color_group))
  end

  test "should show color_group" do
    get :show, id: @color_group.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @color_group.to_param
    assert_response :success
  end

  test "should update color_group" do
    put :update, id: @color_group.to_param, color_group: @color_group.attributes
    assert_redirected_to color_group_path(assigns(:color_group))
  end

  test "should destroy color_group" do
    assert_difference('ColorGroup.count', -1) do
      delete :destroy, id: @color_group.to_param
    end

    assert_redirected_to color_groups_path
  end
end
