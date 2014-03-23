class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  has_merit
  has_many :votes_received, primary_key: 'id', foreign_key: 'user_id', class_name: 'Vote'
  has_many :votes_cast, primary_key: 'id', foreign_key: 'target_user_id', class_name: 'Vote'
  has_many :links
  has_many :topics
  has_many :comments_received, primary_key: 'id', foreign_key: 'user_id', class_name: 'Comment'
  has_many :comments_written, primary_key: 'id', foreign_key: 'target_user_id', class_name: 'Comment'

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body

  def recalculate_reputation
    total = 0

    total += self.votes_received.where(value: -2).count * -2
    total += self.votes_received.where(value: -1).count * -1
    total += self.votes_received.where(value: +1).count * +10
    total += self.votes_received.where(value: +2).count * +20

    total += self.votes_cast.where(value: -2).count * -1
    total += self.votes_cast.where(value: -1).count * +1
    total += self.votes_cast.where(value: +1).count * +1
    total += self.votes_cast.where(value: +2).count * -1

    self.reputation = total
    self.save
  end

  def moderator
    true
  end

  def can_edit?(votable)
    false
  end
end
