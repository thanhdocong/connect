require 'test_helper'

class UserTest < ActiveSupport::TestCase
  #define method before test start
  def setup
  	#declare instance variable @user for user everywhere in test
  	@user=User.new(name: "Sreang Rathanak", email: "Rathanak@jame.com",
  		password: "1234567890",password_confirmation: "1234567890")
  end
  #test if user is not valid
  test "user should be valid" do
  	#user assert_not method as failure message if not valid user
  	assert @user.valid?
  end
  #test if user name is not empty
  test "user name should be present" do
  	#set user name to blank
  	@user.name=""
  	#assert_not method use to return true if user name is empty or nil
  	assert_not @user.valid?
  end
  #test if user email is not empty
  test "user email should be present" do
  	#set user email to blank
  	@user.email=""
  	#assert_not method use to return true if user email is empty or nil
  	assert_not @user.valid?
  end
  #test if user name is longer than limit length
  test "user name should not be longer than 60 charater" do
  	#set user name to letter a for 60 length
  	@user.name="a"* 60
  	#assert_not method use to return true if user name is longer than 60 or nil
  	assert_not @user.valid?
  end
  #test if user email is longer than limit length
  test "user email should not be longer than 100 charater" do
  	#set user email to letter a for 100 length
  	@user.email="a"* 100
  	#assert_not method use to return true if user email is longer than 100 or nil
  	assert_not @user.valid?
  end
  #test user email save as downcase
  test "user email should save as downcase" do
  	#define variable to contain email with mix case
  	mixed_case_email="Jame@SamRa.CoM"
  	#set user email to mixed case email
  	@user.email=mixed_case_email
  	#save the user
  	@user.save
  	#check if user mail have been saved in downdcase or not?
  	assert_equal mixed_case_email.downcase, @user.reload.email
  end

  #test if user password minimum requiement
  test "user password minimum" do
  	#check if use password = password confirmation and = "a" *5 digit
  	@user.password=@user.password_confirmation="a"* 5
  	#assert_not method use to return true if user password is longer than 10 or nil
  	assert_not @user.valid?
  end
  #test user email follow the format
  test "user email which validation should accept valid format" do
	#declear array of valid format for store the right format  	
	valid_formats = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
	#%w[user@example.com USER@jame.COM A_UE-CAM@jame.sam.org first.last@jame.jp alice+bob@abc.cn]
	# run loop to get each item in the array to stroy in temperary variable
	valid_formats.each do |valid_format|
		#set user email to valid format
		@user.email=valid_format
		#check if user email is follow the format and add second arg to give more infomation
		assert @user.valid?, "#{valid_format.inspect} should be valid"
	end
  end
  #test user email not follow the format
  test "user email which validation should reject invalid format" do
	#declear array of valid format for store the right format  	
	invalid_formats = %w[user@example,com user_at_foo.org user.name@example. foo@bar_baz.com foo@bar+baz.com]
	# run loop to get each item in the array to stroy in temperary variable
	invalid_formats.each do |invalid_format|
		#set user email to invalid format
		@user.email=invalid_format
		#check if user email is not followed the format and add second arg to give more infomation
		assert_not @user.valid?, "#{invalid_format.inspect} should be invalid"
	end
  end
  #test user email address should have only one
  test "user email address should be unique" do
  	#define variable duplicate_user get the user duplicate from user.dup method
  	duplicate_user=@user.dup
  	#update duplicate_user mail with @user mail UPPer case
  	duplicate_user.email=@user.email.upcase
  	#save user
  	@user.save
  	#check if user have already or not
  	assert_not duplicate_user.valid?
  end
end
