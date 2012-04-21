require 'test_helper'

class FixturesControllerTest < ActionController::TestCase
  setup do
    @fixture = fixtures(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:fixtures)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create fixture" do
    assert_difference('Fixture.count') do
      post :create, fixture: @fixture.attributes
    end

    assert_redirected_to fixture_path(assigns(:fixture))
  end

  test "should show fixture" do
    get :show, id: @fixture.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @fixture.to_param
    assert_response :success
  end

  test "should update fixture" do
    put :update, id: @fixture.to_param, fixture: @fixture.attributes
    assert_redirected_to fixture_path(assigns(:fixture))
  end

  test "should destroy fixture" do
    assert_difference('Fixture.count', -1) do
      delete :destroy, id: @fixture.to_param
    end

    assert_redirected_to fixtures_path
  end
end
