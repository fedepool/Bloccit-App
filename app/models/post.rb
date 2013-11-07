class Post < ActiveRecord::Base
  has_many :comments
  belongs_to :user
  #update the model. Add belong_to.
  attr_accessible :body, :title
  default_scope order('created_at DESC')
end
