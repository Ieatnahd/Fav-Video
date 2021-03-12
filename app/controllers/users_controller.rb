class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show, :edit]
  before_action :require_current_user, only: [:edit]
  
  def index
    @users = User.order(id: :desc).page(params[:page]).per(25)
  end
  
  def show
    @user = User.find(params[:id])
    @items = @user.items.order(id: :desc).page(params[:page])
    counts(@user)
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = 'ユーザを登録しました。'
      redirect_to @user
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      render :new
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = 'ユーザーのパスワードを変更しました。'
      redirect_to @user
    else
      flash.now[:danger] = 'ユーザのパスワードの変更に失敗しました。'
      render :new
    end
  end
  
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    
    flash[:success] = 'ユーザーは削除されました。'
    redirect_to root_url
  end
  
  def likes
    @user = User.find(params[:id])
    @likes = @user.likes.page(params[:page])
    counts(@user)
  end
  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
