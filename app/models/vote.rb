class Vote < ActiveRecord::Base
  attr_accessible :user_id, :value, :votable_id, :votable_type
  belongs_to :votable, polymorphic: true
  belongs_to :user

  belongs_to :target_user, primary_key: 'target_user_id', foreign_key: 'id', class_name: 'User'

  before_save :set_target_user_id

  def set_target_user_id
    self.target_user_id = self.votable.user_id
  end

end
