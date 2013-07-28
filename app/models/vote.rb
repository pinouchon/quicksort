class Vote < ActiveRecord::Base
  attr_accessible :user_id, :value, :votable_id, :votable_type
  belongs_to :votable, polymorphic: true
end
