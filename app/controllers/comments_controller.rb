class CommentsController < ApplicationController
	#declare to check vefore any action happen
	before_action :signed_in_user, only: [:create,:destroy]
	before_action :correct_entry, only: [:destroy, :destroy]
	#action create
def create
	#declare variable to get entries from current user entries
	@comment = current_user.comments.build comment_params
	#if save success
	if @comment.save
		#show message to user
		flash[:success]="Comment create"
		#link to root path
		redirect_to Entry.find(params[:comment][:entry_id])
	else #else
		#reset feed to empty
		#link to home page
		redirect_to Entry.find(params[:comment][:entry_id])
	end
end
#action destroy
def destroy
	#delete the comment
	@comment.destroy
	#show message to the user
	flash[:success]="Comment deleted"
	#link user  or else root path
	redirect_to request.referrer || root_url	
end
private
#define method to return new comment
def comment_params
	#return params of comment 
	params.require(:comment).permit(:content,:entry_id )
end
#define method to check is the user is post that entry or not
def correct_entry
	#declare entry variable to get user post the entry 
      @comment = Comment.find_by(id: params[:id])
      #if entry is nil link to root path
      redirect_to root_url if @comment.nil?
    end
end
