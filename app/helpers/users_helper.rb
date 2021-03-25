module UsersHelper
  def show_friend_button(current_user, user)
    return if current_user == user
    return if user.pending_friends.include?(current_user)
    return if user.friend_requests.include?(current_user)
    
    button_to 'Send Friend request', "/users/#{current_user.id}/friendship/#{user.id}"
    
  end
end
