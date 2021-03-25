class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.ordered_by_most_recent
  end

  def request_friendship
    friend = User.find(params[:id])
    friendship = Friendship.new(user_id: current_user.id, friend_id: friend.id, confirmed: false)
    redirect_to root_path, notice: 'Friendship invite sent' if friendship.save
  end
end
