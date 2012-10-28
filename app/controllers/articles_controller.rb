class ArticlesController < ApplicationController
  def index
    @articles = Article.all
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
