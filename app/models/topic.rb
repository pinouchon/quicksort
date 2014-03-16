class Topic < ActiveRecord::Base
  attr_accessible :description, :name

  has_many :links, dependent: :destroy
  has_many :votes, as: :votable, dependent: :destroy
  belongs_to :user

  include Votable

  validates :name, presence: {message: 'Topic title cannot be blank'}

  def to_param
    "#{id}-#{name.parameterize}"
  end

end
