class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :pass_params
  before_filter :set_recent_votes_and_replies

  def pass_params
    @params = params
    #flash[:notice] = 'This is a new Q&A site. Check the about page for more: ...'
  end

  def set_recent_votes_and_replies
    if user_signed_in?
      @recent_votes = (current_user.votes_cast.
          order('updated_at DESC').
          limit(10) + current_user.votes_received.
          order('updated_at DESC').
          limit(10))[0, 10].sort_by!(&:updated_at).reverse!
      @unseen_votes = @recent_votes.select { |v| v.updated_at > current_user.checked_reputation_at }
      @recent_votes_total = @recent_votes.map { |v| v.value_for(current_user) }.reduce(:+) || 0

      @recent_replies = (current_user.comments_received.
          order('updated_at DESC').
          where('user_id != ?', current_user.id).
          limit(5) + Link.
          where(topic_id: [current_user.topics.map(&:id)]).
          order('updated_at DESC').
          where('user_id != ?', current_user.id).
          limit(5))[0, 5].sort_by!(&:updated_at).reverse!
      @unseen_replies = @recent_replies.select { |r| r.updated_at > current_user.checked_replies_at }
    end

  end
end
