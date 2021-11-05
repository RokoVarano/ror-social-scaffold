class CommentSerializer < ActiveModel::Serializer
  attributes :user_id, :post_id, :content
end
