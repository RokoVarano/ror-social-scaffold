class Friendship < ActiveRecord::Base
  validates :user_id, uniqueness: { scope: :friend_id }
  validates :friend_id, uniqueness: { scope: :user_id }

  belongs_to :user
  belongs_to :friend, class_name: 'User'

  # This filter needs to be deleted after mirror friend relationships have been handled in the database
  # commented this old method for archive and learning purposes
  # def mirror?(friendship)
  #  true if user.id == friendship.friend.id && friend.id == friendship.user.id
  #  false
  # end
end
