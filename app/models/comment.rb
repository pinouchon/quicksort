class Comment < ActiveRecord::Base
  attr_accessible :content, :post_id, :post_type, :user_id

  belongs_to :user
  belongs_to :post, polymorphic: true
  has_many :votes, as: :votable, dependent: :destroy
  belongs_to :target_user, primary_key: 'target_user_id', foreign_key: 'id', class_name: 'User'

  before_save :set_target_user_id

  def set_target_user_id
    self.target_user_id = self.post.user_id
  end

  def url_suffix
    "comment-#{id}"
  end
end
