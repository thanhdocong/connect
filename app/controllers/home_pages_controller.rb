class HomePagesController < ApplicationController
  def home
    if signed_in?
  	  @entry=current_user.entries.build 
      @feed_items=current_user.feed.paginate(page: params[:page])
    else
       entries=Entry.all
      @feed_items=entries.paginate(page: params[:page])
    end
  end

  def help

  end

  def about

  end

  def contact

  end

  def all_entries    
      entries=Entry.all
      @feed_items=entries.paginate(page: params[:page])
  end
  
end
