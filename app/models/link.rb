class Link < ActiveRecord::Base
  attr_accessible :description, :name, :href, :topic_id

  belongs_to :topic
  belongs_to :user
  has_many :votes, as: :votable

  include Votable

  validates_presence_of :name
  validates_presence_of :href

  def href_with_protocol
    href.start_with?('http://') ? href : 'http://' + href
  end

end
