class Topic < ActiveRecord::Base
  attr_accessible :description, :name

  has_many :links
  has_many :votes, as: :votable

  def to_param
    "#{id}/#{name.parameterize}"
  end

end
