class Vote < ActiveRecord::Base
  attr_accessible :user_id, :value, :votable_id, :votable_type
  belongs_to :votable, polymorphic: true
  belongs_to :user

  belongs_to :target_user, primary_key: 'target_user_id', foreign_key: 'id', class_name: User

  before_save :set_target_user_id

  TABLE = {
      received: {
          -2 => -2,
          -1 => -1,
          +1 => +10,
          +2 => +20},
      cast: {
          -2 => -1,
          -1 => +1,
          +1 => +1,
          +2 => -1}
  }

  def set_target_user_id
    self.target_user_id = self.votable.user_id
  end

  def to_s
    name
  end

  # def received_value(cast_or_received)
  #   self.values[cast_or_received][value]
  # end

  def value_for(user)
    if user.id == self.user_id
      TABLE[:cast][value]
    elsif user.id == self.target_user_id
      TABLE[:received][value]
    else
      0
    end
  end

end
