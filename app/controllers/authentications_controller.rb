class AuthenticationsController < ApplicationController
  skip_before_filter :authenticate_user!, :only => :create

  
  def index
    @authentications = current_user.authentications if current_user
  end
  
  def create
#    auth =  request.env["omniauth.auth"]
#    auth = request.env["omniauth.auth"]
#    current_user.authentications.find_or_create_by_provider_and_uid(auth['provider'], auth['uid'])
#    current_user.authentications.update_all(:oauth_token => auth.credentials[:token], :oauth_token_secret => auth.credentials[:secret], :name => auth.info[:nickname])
#    flash[:notice] = "Authentication successful."
#    render :text => "success"
    omniauth = request.env["omniauth.auth"]
    authentication = Authentication.find_by_provider_and_uid(omniauth['provider'], omniauth['uid'])
    if authentication
      flash[:notice] = "Signed in successfully."
      sign_in_and_redirect(:user, authentication.user)
    elsif current_user
      flash[:notice] = "Authentication successful."
      redirect_to authentications_url
    else
      user = User.new
      
      if user.save
        flash[:notice] = "Signed in successfully."
        sign_in_and_redirect(:user, user)
      else
        session[:omniauth] = omniauth.except('extra')
        redirect_to new_user_registration_url
      end
    end
    
  end
  
  def destroy
    @authentication = current_user.authentications.find(params[:id])
    @authentication.destroy
    flash[:notice] = "Successfully destroyed authentication."
    redirect_to authentications_url
  end
end
