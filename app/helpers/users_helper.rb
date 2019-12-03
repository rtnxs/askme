module UsersHelper
  def user_avatar(user)
    #user.avatar_url.present? ? user.avatar_url : asset_path 'avatar.jpg'

    if user.avatar_url.present?
      user.avatar_url
    else
      asset_path 'avatar.jpg'
    end
  end
end
