module UsersHelper
  def link_list(user)
    if current_user.friend_requests.include?(user)
      concat link_to 'Accept', confirm_request_path(user), class: 'profile-link accept link'
      concat ' '
      link_to 'Reject', reject_request_path(user), class: 'profile-link reject link'
    elsif !current_user.pending_friends.include?(user) && current_user != user && !current_user.friend?(user)
      link_to 'Request Friendship', "/users/#{current_user.id}/friendship/#{user.id}",
              class: 'profile-link invite link', method: :post
    end
  end
end
