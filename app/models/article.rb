class Article < ActiveRecord::Base
  attr_accessible :name, :description
  has_many :posts
  belongs_to :user
end
