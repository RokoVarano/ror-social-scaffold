class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :name, presence: true, length: { maximum: 20 }
  validates_uniqueness_of :name
  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :friendships
  has_many :friendships_confirmation, -> { where confirmed: true }, class_name: 'Friendship'
  has_many :friends, through: :friendships_confirmation
  # has_many :inverse_friendships, class_name: 'Friendship', foreign_key: 'friend_id'
  has_many :pending_friendships, -> { where confirmed: false }, class_name: 'Friendship', foreign_key: 'user_id'
  has_many :pending_friends, through: :pending_friendships, source: :friend
  # Changed to inverse instead of inverted due to app using inverse
  has_many :inverse_friendships, -> { where confirmed: false }, class_name: 'Friendship', foreign_key: 'friend_id'
  has_many :friend_requests, through: :inverse_friendships

  # commented this old method for archive and learning purposes

  # def friend_list
  #  friends_array = []

  #  friendships.map do |friendship|
  #    friends_array << friendship.friend if friendship.confirmed
  #  end

  #  inverse_friendships do |f1|
  #    mirrored = false
  #    friendships.map do |f2|
  #      mirrored = true if f1.mirror?(f2)
  #    end

  #    friends_array << f1.friend unless mirrored || !f1.confirmed
  #  end

  #  friends_array.compact
  # end

  def pending_friends
    friendships.map { |friendship| friendship.friend unless friendship.confirmed }.compact
  end

  def friend_requests
    inverse_friendships.map { |friendship| friendship.user unless friendship.confirmed }.compact
  end

  def confirm_friend(user)
    person = inverse_friendships.find { |friendship| friendship.user == user }
    person.confirmed = true
    person.save
    Friendship.create!(user_id: id, friend_id: user.id, confirmed: true)
  end

  def reject_friendship(user)
    friendship = inverse_friendships.find { |f| f.user == user }
    friendship.destroy
  end

  def friend?(user)
    friends.include?(user)
  end

  # commented this old method for archive and learning purposes

  # def friend_posts 
  #  fposts = []
  #  friend_list.map { |friend| friend.posts.map { |post| fposts << post } }
  #  posts.map { |post| fposts << post }
  #  fposts.sort_by { |post| post[:created_at] }.reverse
  # end

  def friends_and_own_posts
    Post.where(user: (self.friends.to_a << self)).sort_by { |post| post[:created_at] }.reverse
    # This will produce SQL query with IN. Something like: select * from posts where user_id IN (1,45,874,43);
  end
end
