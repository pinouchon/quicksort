class Topic < ActiveRecord::Base
  attr_accessible :description, :name

  has_many :links
  has_many :votes, as: :votable
  belongs_to :user

  def to_param
    "#{id}-#{name.parameterize}"
  end

end
