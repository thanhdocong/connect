class EntriesController < ApplicationController
	before_action :signed_in_user, only: [:create,:destroy]
	before_action :correct_user, only: :destroy


#create action
def create
	@entry=current_user.entries.build(entry_params)
	if @entry.save
		flash[:success]="Entry created"
		redirect_to root_url
	else 
		@feed_items=[]
		render 'home_pages/home'
	end
end

#delete action
def destroy
	@entry.destroy
	flash[:success]="Entry deleted"
	redirect_to request.referrer || root_url
end

#action show 
def show
	@entry=Entry.find(params[:id])
    @comments = @entry.comments.paginate(page: params[:page])
end


#private sestion
private
#define method to return new entry
def entry_params
	#return params of entry with following tile body and date
	params.require(:entry).permit(:title,:body)
end

#define method to check is the user is post that entry or not
def correct_user
	#declare entry variable to get user post the entry 
      @entry = current_user.entries.find_by(id: params[:id])
      #if entry is nil link to root path
      redirect_to root_url if @entry.nil?
    end
end
