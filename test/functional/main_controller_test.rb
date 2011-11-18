require 'test_helper'

class MainControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get contact" do
    get :contact
    assert_response :success
  end

  test "should get principles" do
    get :principles
    assert_response :success
  end

  test "should get introduction" do
    get :introduction
    assert_response :success
  end

  test "should get strategy" do
    get :strategy
    assert_response :success
  end

end
