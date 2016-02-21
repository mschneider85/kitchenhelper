module ApplicationHelper
  def avatar_url(user)
    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
    user.avatar.url.present? ? user.avatar.url : "http://gravatar.com/avatar/#{gravatar_id}.png?s=400&d=monsterid"
  end
end
