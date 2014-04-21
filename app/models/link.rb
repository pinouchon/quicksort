class Link < ActiveRecord::Base
  attr_accessible :description, :name, :href, :topic_id

  belongs_to :topic
  belongs_to :user
  has_many :votes, as: :votable, dependent: :destroy
  has_many :comments, as: :post, dependent: :destroy

  include Votable

  validates_presence_of :name
  validates_presence_of :href

  def href_with_protocol
    href.start_with?('http') ? href : 'http://' + href
  end

  def href_without_protocol
    href.sub('http://', '').sub('https://', '').sub(/\/$/, '')
  end

  def url_suffix
    "link-#{id}"
  end

end
