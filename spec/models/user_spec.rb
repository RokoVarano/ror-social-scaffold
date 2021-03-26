require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it 'should has many posts' do
      t = User.reflect_on_association(:posts)
      expect(t.macro).to eq(:has_many)
    end
    it 'should has many comments' do
      a = User.reflect_on_association(:comments)
      expect(a.macro).to eq(:has_many)
    end
    it 'should has many likes' do
      e = User.reflect_on_association(:likes)
      expect(e.macro).to eq(:has_many)
    end
    it 'should has many friendships' do
      e = User.reflect_on_association(:friendships)
      expect(e.macro).to eq(:has_many)
    end
    it 'should has many friends' do
      e = User.reflect_on_association(:friends)
      expect(e.macro).to eq(:has_many)
    end
    it 'should has many inverse_friendship' do
      e = User.reflect_on_association(:inverse_friendships)
      expect(e.macro).to eq(:has_many)
    end
  end
end
