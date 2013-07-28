class Link < ActiveRecord::Base
  attr_accessible :description, :name, :href, :topic_id

  belongs_to :topic
  has_many :votes, as: :votable

  validates_presence_of :name
  validates_presence_of :href

  def href_with_protocol
    href.start_with?('http://') ? href : 'http://' + href
  end

  def user_vote(user)
    votes.where('user_id = ?', user.id).first
  end

  def votes_total
    votes.map(&:value).reduce(:+)
  end
end
