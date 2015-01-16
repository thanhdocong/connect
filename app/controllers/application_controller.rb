class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper

   #private block
   #Confirms a signed in user
   def signed_in_user
   		unless signed_in?
   			#store_location
   			flash[:danger]="Please Sign in."
   			redirect_to signin_url
   		end
   end
end
