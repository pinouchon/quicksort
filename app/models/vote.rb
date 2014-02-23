class Vote < ActiveRecord::Base
  attr_accessible :user_id, :value, :votable_id, :votable_type
  belongs_to :votable, polymorphic: true
  belongs_to :user

  belongs_to :author, primary_key: 'author_id', foreign_key: 'id', class_name: 'User'

  before_save :set_author_id

  def set_author_id
    self.author_id = self.votable.user_id
  end

end
