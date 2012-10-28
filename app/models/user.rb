class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model

  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name
  # attr_accessible :title, :body

  has_many :authentications
  has_many :articles
  has_many :posts



  def apply_omniauth(omniauth)
    authentications.build(:provider => omniauth['provider'], :uid => omniauth['uid'], :oauth_token => omniauth.credentials[:token], :oauth_token_secret => omniauth.credentials[:secret], :name => omniauth.info[:nickname])
  end
  
  def initialize_fields
    self.status = "Active"
    self.expiration_date = 1.year.from_now
  end
  
  
  
end
