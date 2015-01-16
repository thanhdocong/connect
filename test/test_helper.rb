ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
#Use Minitest::Reporters for make TestCase look more better
require "minitest/reporters"
Minitest::Reporters.use!
class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  #define method to return true if a test user is logged in.
  def is_signed_in?
  	#return if session nil or not
  	!session[:user_id].nil?
  end
  ## Logs in a test user.
  #def sign_in_as(user, options = {})
  #  password    = options[:password]    || 'password'    
  #  if integration_test?
  #    post signin_path, session: { email:       user.email,
  #                                password:    password}
  #  else
  #    session[:user_id] = user.id
  #  end
  #end

#  private

 #   # Returns true inside an integration test.
  #  def integration_test?
   #   defined?(post_via_redirect)
   # end
end