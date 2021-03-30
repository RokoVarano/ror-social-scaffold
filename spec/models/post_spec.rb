require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'associations' do
    it 'should belong to user' do
      t = Post.reflect_on_association(:user)
      expect(t.macro).to eq(:belongs_to)
    end
    it 'should has many comments' do
      a = Post.reflect_on_association(:comments)
      expect(a.macro).to eq(:has_many)
    end
    it 'should has many likes' do
      e = Post.reflect_on_association(:likes)
      expect(e.macro).to eq(:has_many)
    end
  end
end
