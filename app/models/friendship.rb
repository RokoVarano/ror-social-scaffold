class Friendship < ActiveRecord::Base
  scope :my_friends, -> { where('user_id: current_user.id') }

  belongs_to :user
  belongs_to :friend, class_name: 'User'
end
