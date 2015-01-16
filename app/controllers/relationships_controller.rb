class RelationshipsController < ApplicationController
    before_action :signed_in_user

    #action create
    def create
    	@user = User.find(params[:followed_id])
    	current_user.follow(@user) unless current_user.following?(@user)
        respond_to do |format|
        	format.html{redirect_to @user}
        	format.js
        end
    end

    #action destroy
    def destroy
    	@user = Relationship.find(params[:id]).followed
    	@user = relationship.followed if relationship 
        current_user.unfollow(@user)
        respond_to do |format|
        	format.html{redirect_to @user}
        	format.js
        end
    end
end
