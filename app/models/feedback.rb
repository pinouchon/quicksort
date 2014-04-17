class Feedback < ActiveRecord::Base
  attr_accessible :content, :email

  validates_presence_of :content
  validates_format_of :email, with: /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/
end
