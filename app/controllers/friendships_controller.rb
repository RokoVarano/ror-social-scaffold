class FriendshipsController < ApplicationController
  def index
    @friendships = Friendship.all
  end

  def new
    @friendship = Friendship.new
  end

  def create
    user = User.find(params[:id])
    Friendship.create(user_id: current_user.id, friend_id: user.id, confirmed: false)
    redirect_to root_path, notice: 'Friendship invite sent'
  end
  
  def confirm_request
    user = User.find(params[:id])
    current_user.confirm_friend(user)
    redirect_to user, notice: 'friend request accepted'
  end

  def reject_request
    user = User.find(params[:id])
    current_user.reject_friendship(user)
    redirect_to root_path, notice: 'request rejected'
  end

  def pending_friends
    @pending_friends = current_user.pending_friends
  end
end
