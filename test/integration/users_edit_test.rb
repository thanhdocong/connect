require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
 #define start up method
 def setup
 	#declare variable and assign its value
    @user = users(:rathanak)
  end
  #test unseccessfull edit user
  test "unsuccessful edit" do
  	#call method sign in as from session helper
    #sign_in_as(@user)
    #get the edit user path from user assign in start up method above
    get edit_user_path(@user)
    #try to 
    patch user_path(@user), user: { name:  '',
                                    email: 'foo@invalid',
                                    password:              'foo',
                                    password_confirmation: 'bar' }
    #assert_template to check that a failed submission re-renders the rdit action
    #==>assert_template 'users/edit'
  end
  #test successful edit
  test "successful edit" do
    #call method sign in as from session helper
    #sign_in_as(@user)
    #get the edit user path from user assign in start up method above
    get edit_user_path(@user)
    #declare and assign value to each paramete
    name  = "Foo Bar"
    email = "foo@bar.com"
    #
    patch user_path(@user), user: { name:  name,
                                    email: email,
                                    password:              "",
                                    password_confirmation: "" }
    #
    assert_not flash.empty?
    #
    #assert_redirected_to @user
    # reload page user again
    #@user.reload
    #
    #assert_equal @user.name,  name
    #
    #assert_equal @user.email, email
  end
end
