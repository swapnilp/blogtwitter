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

      if !current_user.authentications.blank? 
        auth = current_user.authentications.first
        @client = Twitter::Client.new(
                                      :oauth_token => auth.oauth_token,
                                      :oauth_token_secret => auth.oauth_token_secret
                                      )
        @client.update("comment  on #{@atricle.name}")
      end
        redirect_to article_path(@atricle)
    end
  end
end
