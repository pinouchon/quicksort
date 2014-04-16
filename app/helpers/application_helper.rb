module ApplicationHelper
  def moderator?
    user_signed_in? && current_user.moderator?
  end

  def time_ago(time)
    a = (Time.now-time).to_i

    case a
      when 0 then
        'just now'
      when 1..59 then
        a.to_s+'s ago'
      when 60..119 then
        '1m ago' #120 = 2 minutes
      when 60..3540 then
        (a/60).to_i.to_s+'m ago'
      when 3541..7100 then
        '1h ago' # 3600 = 1 hour
      when 7101..82800 then
        ((a+99)/3600).to_i.to_s+'h ago'
      when 82801..172000 then
        'a day ago' # 86400 = 1 day
      when 172001..518400 then
        ((a+800)/(60*60*24)).to_i.to_s+' days ago'
      when 518400..1036800 then
        'a week ago'
      else
        time.strftime('%d %b %Y')
      #((a+180000)/(60*60*24*7)).to_i.to_s+' weeks ago'
    end
  end

  def votable_path(votable)
    return topic_path(votable) if votable.class == Topic
    return link_path(votable) if votable.class == Link
    return comment_path(votable) if votable.class == Comment
  end

end
