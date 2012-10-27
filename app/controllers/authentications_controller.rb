class AuthenticationsController < ApplicationController
  def index
    @authentications = current_user.authentications if current_user
  end
  
  def create
    auth =  request.env["omniauth.auth"]
    #puts auth.inspect
    #puts auth.credentials[:access_token]
    #puts auth[:oauth_token_secret]
    #render :text => auth



    auth = request.env["omniauth.auth"]
    current_user.authentications.find_or_create_by_provider_and_uid(auth['provider'], auth['uid'])
    current_user.authentications.update_all(:oauth_token => auth.credentials[:token], :oauth_token_secret => auth.credentials[:secret], :name => auth.info[:nickname])
    flash[:notice] = "Authentication successful."
    #redirect_to authentications_url
    render :text => "success"
  end
  
  def destroy
    @authentication = current_user.authentications.find(params[:id])
    @authentication.destroy
    flash[:notice] = "Successfully destroyed authentication."
    redirect_to authentications_url
  end
end
