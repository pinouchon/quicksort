class Topic < ActiveRecord::Base
  attr_accessible :user_id, :description, :name

  has_many :links, dependent: :destroy
  has_many :votes, as: :votable, dependent: :destroy
  has_many :comments, as: :post, dependent: :destroy
  belongs_to :user

  include Votable

  validates :name, presence: {message: 'Topic title cannot be blank'}

  # scope :top5,
  #       select("songs.id, OTHER_ATTRS_YOU_NEED, count(listens.id) AS listens_count").
  #           joins(:listens).
  #           group("songs.id").
  #           order("listens_count DESC").
  #           limit(5)
  def links_sorted_by_vote
    links
    # select("songs.id, OTHER_ATTRS_YOU_NEED, count(listens.id) AS listens_count").
    #     joins(:listens).
    #     group("songs.id").
    #     order("listens_count DESC").
    #     limit(5)
  end

  def to_param
    "#{id}-#{name.parameterize}"
  end

  def topic
    self
  end

  def to_s
    name
  end

  def url_suffix
    "topic-#{id}"
  end

end
