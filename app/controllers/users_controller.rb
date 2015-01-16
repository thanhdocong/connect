class UsersController < ApplicationController
  
  before_action :signed_in_user, only:[:index,:edit,:update, :destroy]

  #action new
  def new
  	@user=User.new
  end
  #action index
  def index
   
    @users=User.paginate(page: params[:page])
  end
  #action show user
  def show
  	@user=User.find(params[:id])
    @entries = @user.entries.paginate(page: params[:page])
  end
  #action create user
  def create
  	@user = User.new(user_params)
  	if @user.save
      sign_in @user
  		flash[:success]="Welcome to the Blog System!"
  		redirect_to @user
  	else 
  		render 'new'
  	end
  end
  #action edit
  def edit
    @user=User.find(params[:id])
  end
  #action update
  def update
    @user=User.find(params[:id])
    if @user.update_attributes(user_params)
      #show message about successful edit
      flash[:success]="Profile update"
      #link to user page 
      redirect_to @user
    else
      render 'edit'
    end
  end
  #action destroy
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end
  #define method following
  def following
    @title="Following"
    @user=User.find(params[:id])
    @users=@user.following.paginate(page: params[:page])
    render 'show_follow'
  end
  #define method follower
  def followers
    @title="Followers"
    @user=User.find(params[:id])
    @users=@user.followers.paginate(page: params[:page])
    render 'show_follow'
  end
  #private section
  private
  #define methods user_params
  def user_params
  	#
  	params.require(:user).permit(:name,:email,:password,:password_confirmation)
  end
  #define method to confirme that user is signed in
  def signed_in_user
    
    unless signed_in?
      flash[:danger]="Please sign in"
      redirect_to signin_url
    end
  end
  #define method to comfirme that user is correct
  def correct_user
    @user=User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end
end
