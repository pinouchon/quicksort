class Link < ActiveRecord::Base
  attr_accessible :description, :name, :href, :topic_id

  belongs_to :topic
  belongs_to :user
  has_many :votes, as: :votable

  validates_presence_of :name
  validates_presence_of :href

  def href_with_protocol
    href.start_with?('http://') ? href : 'http://' + href
  end

  def user_vote(user)
    return nil if !user
    votes.where('user_id = ?', user.id).first
  end

  def total_votes
    votes.map(&:value).reduce(:+) || 0
  end

  def total_votes_without(user_id = nil)
    return total_votes if !user_id
    votes.where('user_id != ?', user_id).map(&:value).reduce(:+) || 0
  end
end
