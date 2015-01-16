require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  def setup
    @user = users(:rathanak)
  end

  test "should get new" do
    get :new
    assert_response :success
    assert_select "title", "Sign up | Ruby on Rails My Demo App"
  end
  test "should redirect edit when not logged in" do
    get :edit, id: @user
    assert_redirected_to signin_url
  end

  test "should redirect update when not logged in" do
    patch :update, id: @user, user: { name: @user.name, email: @user.email }
    assert_redirected_to signin_url
  end
end
