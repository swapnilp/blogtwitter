class PostsController < ApplicationController
  def new
     @article = Article.where(:id => params[:article_id]).first
     @post = Post.new
  end

  def create
    puts @atricle = Article.where(:id => params[:article_id]).first
    @post = Post.new(params[:post])
    @post.article_id = @atricle.id
    @post.user_id = current_user.id
    if @post.save
      redirect_to article_path(@atricle)
    end
  end
end
