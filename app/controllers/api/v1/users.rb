module API
  module V1
    class Users < Grape::API
      include API::V1::Defaults
      resource :users do
        desc 'Return all users'
        get '' do
          User.all
        end
        params do
          requires :id, type: String, desc: 'ID of the user'
        end
        get ':id' do
          User.where(id: permitted_params[:id]).first!
        end
        get ':id/posts' do
          Post.where(user_id: request.path.split('/')[4])
        end
        get ':id/posts/:post_index' do
          Post.where(user_id: request.path.split('/')[4]).sort[request.path.split('/')[6].to_i - 1]
        end
        get ':id/posts/:post_id/comments' do
          Post.where(user_id: request.path.split('/')[4]).sort[request.path.split('/')[6].to_i - 1].comments.sort
        end
        get ':id/posts/:post_id/comments/:comment_index' do
          post = Post.where(user_id: request.path.split('/')[4]).sort[request.path.split('/')[6].to_i - 1]
          post.comments.sort[request.path.split('/')[8].to_i - 1]
        end
        post ':id/posts' do
          Post.create(user_id: request.path.split('/')[4], content: params[:content])
        end
        post ':id/posts/:post_id/comments' do
          post = Post.where(user_id: request.path.split('/')[4]).sort[request.path.split('/')[6].to_i - 1]
          Comment.create(user_id: request.path.split('/')[4], post_id: post[:id], content: params[:content])
        end
      end
    end
  end
end
