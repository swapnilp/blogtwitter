class ArticlesController < ApplicationController
  def index
    @articles = Article.all
    @user = current_user
  end
  
  def new
    @article = Article.new
  end
  
  def show
    @article = Article.where(:id => params[:id]).first
  end

  def create
    @article = Article.new(params[:article])
    @article.user_id = current_user.id
    if @article.save
      if !current_user.authentications.blank?
        auth = current_user.authentications.first
        @client = Twitter::Client.new(
                                      :oauth_token => auth.oauth_token,
                                      :oauth_token_secret => auth.oauth_token_secret
                                      )
        @client.update("created article - #{@article.name}")
      end
      redirect_to articles_path
    else
      render :action => 'new'
    end
  end
  
  def edit
  end
  
  def update
  end

  def desroy
  end
end
