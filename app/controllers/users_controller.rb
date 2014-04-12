class UsersController < ApplicationController
  def check_reputation
    return if !user_signed_in?
    current_user.checked_reputation_at = Time.now
    current_user.save
    render text: 'ok'
  end

  def check_replies
    return if !user_signed_in?
    current_user.checked_replies_at = Time.now
    current_user.save
    render text: 'ok'
  end
end
