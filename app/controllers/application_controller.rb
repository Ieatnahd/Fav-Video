class ApplicationController < ActionController::Base
  
  include SessionsHelper
  
  private
  
  def require_user_logged_in
    unless logged_in?
      redirect_to login_url
    end
  end
  
  def require_current_user
    unless current_user == User.find(params[:id])
      redirect_to login_url
    end
  end
  
  def counts(user)
    @count_items = user.items.count
    @count_likes = user.likes.count
  end
end
