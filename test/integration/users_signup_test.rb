require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  #test if use fill the information for sign up invalide
  test "invalid signup information" do
  	#get sign up path
  	get signup_path
  	#Assertion that the numeric result of evaluating an expression is not changed before and after invoking
  	#assert_no_difference is equivalent to recording the user count, posting the data, and verifying that the count is the same
    assert_no_difference 'User.count' do
  		post users_path, user:{name: "",email: "invalid@user", password: "123",password_confirmation: "124"}
  	end
  	#assert_template to check that a failed submission re-renders the new action
  	assert_template 'users/new'
  end
  #test if all information user input is valid
  test "valid signup information" do
    #get user path
    get signup_path
    #declare and init variable for user information 
    name     = "Example User"
    email    = "user@example.com"
    password = "password"
    #Test numeric difference between the return value of an expression as a result of what is evaluated
    # againt assert_no_difference
    assert_difference 'User.count', 1 do
      post_via_redirect users_path, user: { name:  name,
                                            email: email,
                                            password:              password,
                                            password_confirmation: password }
    end
    #assert_template to check that a failed submission re-renders the show action
    assert_template 'users/show'
    #to check that it sussec sign in or not
    assert is_signed_in?
  end
end
