require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'associations' do
    it 'should belong to user' do
      t = Comment.reflect_on_association(:user)
      expect(t.macro).to eq(:belongs_to)
    end
    it 'should belong to post' do
      t = Comment.reflect_on_association(:post)
      expect(t.macro).to eq(:belongs_to)
    end
  end
end
