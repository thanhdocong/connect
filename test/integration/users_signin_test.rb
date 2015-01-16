require 'test_helper'

class UsersSigninTest < ActionDispatch::IntegrationTest
    #define method set up to run when test start
    def setup
        #declare variable to get fro user rathanak in test/fixtures/users/yml
        @user=users(:rathanak)
    end
   #test if user sign in with wrong information
  test "sign in with invalid information" do
    #get sing in path
    get signin_path
    #assert_template to check that a failed submission re-renders the new action
    assert_template 'sessions/new'
    post signin_path, session: { email: "", password: "" }
    #assert_template to check that a failed submission re-renders the new action
    assert_template 'sessions/new'
    #check if flash method is empty
    assert_not flash.empty?
    #get root path
    get root_path
    #check if flash is not empty
    assert flash.empty?
  end
  #test sign in with valid information
  test "sign in with valid information followed by sign out" do
    #get sign in path
    get signin_path
    #post to sign in with following user email and password
    post signin_path, session: { email: @user.email, password: '1234567890' }
    #
    assert is_signed_in?
    #
    assert_redirected_to @user
    #
    follow_redirect!
    #
    assert_template 'users/show'
    #
    assert_select "a[href=?]", signin_path, count: 0
    #
    assert_select "a[href=?]", signout_path
    #
    assert_select "a[href=?]", user_path(@user)
    #
    delete signout_path
    #
    assert_not is_signed_in?
    #
    assert_redirected_to root_url
    #
    follow_redirect!
    #
    assert_select "a[href=?]", signin_path
    #
    assert_select "a[href=?]", signout_path, count: 0
    #
    assert_select "a[href=?]", user_path(@user), count: 0
  end
end
