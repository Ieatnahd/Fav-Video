class FavoritesController < ApplicationController
  before_action :require_user_logged_in
  
  def create
    item = Item.find(params[:item_id])
    current_user.favorite(item)
    flash[:success] = '投稿をいいねしました。'
    redirect_to item
  end

  def destroy
    item = Item.find(params[:item_id])
    current_user.unfavorite(item)
    flash[:success] = '投稿のいいねを取り消しました。'
    redirect_to item
  end
end
