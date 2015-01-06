class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  has_merit
  has_many :votes_cast, primary_key: 'user_id', foreign_key: 'id', class_name: Vote
  has_many :votes_received, primary_key: 'target_user_id', foreign_key: 'id', class_name: Vote
  #has_many :votes
  has_many :links
  has_many :topics
  has_many :comments_written, primary_key: 'user_id', foreign_key: 'id', class_name: Comment
  has_many :comments_received, primary_key: 'target_user_id', foreign_key: 'id', class_name: Comment

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body

  #User.joins(topics: :votes, links: :votes).select('votes.value as value, votes.id as id').where('users.id = 1').group('votes.id').all.map{|v| [v.id, v.value]}

  def recalculate_reputation
    total = 0

    Vote::TABLE[:received].each do |k, v|
      total += self.votes_received.where(value: k).count * v
    end
    Vote::TABLE[:cast].each do |k, v|
      total += self.votes_cast.where(value: k).count * v
    end

    self.reputation = total
    self.save
  end

  def moderator?
    email == 'pinouchon@gmail.com'
  end

  def can_edit?(votable)
    false
  end
end
