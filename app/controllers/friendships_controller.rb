class FriendshipsController < ApplicationController
  def index
    @friendships = Friendship.my_friends
  end

  def new
    @friendship = Friendship.new
  end

  def create
    @user = current_user
    @friend = User.find(params[:id])
    friendship = Friendship.new(user_id: @user.id, friend_id: @friend.id, confirmed: false)
    redirect_to root_path, notice: 'Friendship invite sent' if friendship.save
  end
end
