class ItemsController < ApplicationController
  before_action :require_user_logged_in
  GOOGLE_API_KEY = Rails.application.credentials.google[:api_key]
  before_action :correct_user, only: [:destroy]
  
  def find_videos(keyword, before: Time.now)
    service = Google::Apis::YoutubeV3::YouTubeService.new
    service.key = GOOGLE_API_KEY
    
    next_page_token = nil
    opt = {
      q: keyword,
      type: 'video',
      max_results: 1,
      order: :relevance,
      page_token: next_page_token,
      published_before: before.iso8601
    }
    service.list_searches(:snippet, opt)
  end
  
  def index
    @items = Item.order(id: :desc).page(params[:page]).per(25)
  end

  def show
    @item = Item.find_by(id: params[:id])
    if @item == nil
      flash[:danger] = 'その記事は存在しません'
      redirect_to items_path
    else
    end
  end

  def new
    @item = current_user.items.build
  end

  def create
    @item = current_user.items.build(content: params[:video][:content], input_id: params[:video][:input_id])
    youtube_data = find_videos(params[:video][:input_id])
    if youtube_data == nil
      flash[:danger] = 'そのIDの動画はありません。'
      render :new and return
    else
      youtube_data.items.each do |item|
        snippet = item.snippet
        @item.video_id = item.id.video_id
        @item.title = snippet.title
        @item.channel = snippet.channel_title
        @item.thumbnail_url = snippet.thumbnails.default.url
      end
    end
    if @item.input_id != @item.video_id
      @item.destroy
      flash[:danger] = 'そのIDの動画はありません。'
      render :new and return
    else
    end
    if @item.save
      flash[:success] = '投稿に成功しました。'
      redirect_to items_path
    else
      flash[:danger] = '投稿に失敗しました。'
      render :new
    end
  end

  def destroy
    @item.destroy
    flash[:success] = '投稿を削除しました。'
    redirect_to root_path
  end
  
  private
  
  def correct_user
    @item = current_user.items.find_by(id: params[:id])
    unless @item
      redirect_to root_url
    end
  end
end
