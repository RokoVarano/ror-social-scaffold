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
  has_many :inverse_friendships, class_name: 'Friendship', foreign_key: 'friend_id'

  def friend_list
    friends_array = []

    friendships.map do |friendship|
      friends_array << friendship.friend if friendship.confirmed
    end

    inverse_friendships do |f1|
      mirrored = false
      friendships.map do |f2|
        mirrored = true if f1.mirror?(f2)
      end

      friends_array << f1.friend unless mirrored || !f1.confirmed
    end

    friends_array.compact
  end

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

  def friend_posts
    fposts = []
    friend_list.map { |friend| friend.posts.map { |post| fposts << post } }
    posts.map { |post| fposts << post }
    fposts.sort_by { |post| post[:created_at] }.reverse
  end
end
