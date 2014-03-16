module ApplicationHelper
  def moderator
    user_signed_in? && current_user.moderator
  end
end
