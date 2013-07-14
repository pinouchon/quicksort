class Topic < ActiveRecord::Base
  attr_accessible :description, :name

  has_many :links

  def to_param
    "#{id}/#{name.parameterize}"
  end

end
