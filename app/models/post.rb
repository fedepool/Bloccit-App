class Post < ActiveRecord::Base
  has_many :comments
  belongs_to :user
  belongs_to :topic
  #update the model. Add belong_to.
  attr_accessible :body, :title, :topic, :image

  default_scope order('created_at DESC')
  scope :visible_to, lambda { |user| user ? scoped : joins(:topic).where('topics.public' => true) }

  mount_uploader :image, ImageUploader

  after_create :create_vote

  def up_votes
    self.votes.where(value: 1).count
  end

  def down_votes
    self.votes.where(value: -1).count
  end 

   def points
    self.votes.sum(:value).to_i
  end  

  def update_rank
    age = (self.created_at - Time.new(1970,1,1)) / 86400
    new_rank = points + age

    self.update_attribute(:rank, new_rank)
  end

  has_many :comments, dependent: :destroy
  has_many :votes, dependent: :destroy
  has_many :favorites, dependent: :destroy

  validates :title, length: { minimum: 5 }, presence: true
  validates :body, length: { minimum: 20 }, presence: true
  validates :topic, presence: true
  validates :user, presence: true

  private

  # Who ever created a post, should automatically be set to "voting" it up.
  def create_vote
    self.user.votes.create(value: 1, post: self)
  end
end
