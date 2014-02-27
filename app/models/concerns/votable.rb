require 'active_support/concern'

module Votable
  extend ActiveSupport::Concern

  included do
    #scope :disabled, -> { where(disabled: true) }
  end

  #module ClassMethods
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
  #end
end