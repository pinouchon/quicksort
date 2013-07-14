class Link < ActiveRecord::Base
  attr_accessible :description, :name, :href, :topic_id

  belongs_to :topic

  validates_presence_of :name
  validates_presence_of :href
end
