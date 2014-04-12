class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :pass_params

  def pass_params
    @params = params
    if user_signed_in?
      checked_reputation_at = current_user.checked_reputation_at ||= 10.years.ago
      @unseen_votes = (current_user.votes_cast.
          where('updated_at > ?', checked_reputation_at).
          order('updated_at DESC').
          limit(10) + current_user.votes_received.
          where('updated_at > ?', checked_reputation_at).
          order('updated_at DESC').
          limit(10))[0, 10]
      @recent_votes = (current_user.votes_cast.
          order('updated_at DESC').
          limit(10) + current_user.votes_received.
          order('updated_at DESC').
          limit(10))[0, 10]
      @recent_votes_total = @recent_votes.map { |v| v.value_for(current_user) }.reduce(:+) || 0

      @unseen_replies = []
      @recent_replies = []
    end

  end
end
