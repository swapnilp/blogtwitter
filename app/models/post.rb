class Post < ActiveRecord::Base
  attr_accessible :post
  belongs_to :article
end
