module API
    module V1
      class Users < Grape::API
        include API::V1::Defaults
        resource :users do
          desc "Return all users"
          get "" do
            User.all
          end
        desc "Return a user"
          params do
            requires :id, type: String, desc: "ID of the user"
          end
          get ":id" do
            puts(@current_user)
            User.where(id: permitted_params[:id]).first!
          end
          get ":id/posts" do
            Post.where(user_id: request.path.split("/")[4])
          end
          get ":id/posts/:post_index" do
            Post.where(user_id: request.path.split("/")[4]).sort[request.path.split("/")[6].to_i - 1]
          end
          get ":id/posts/:post_id/comments" do
            puts(request.path)
            post = Post.where(user_id: request.path.split("/")[4]).sort[request.path.split("/")[6].to_i - 1]
            post.comments.sort
            # Comment.where(user_id: request.path.split("/")[4]).where(post_id: request.path.split("/")[6]).sort
          end
          get ":id/posts/:post_id/comments/:comment_index" do
            post = Post.where(user_id: request.path.split("/")[4]).sort[request.path.split("/")[6].to_i - 1]
            post.comments.sort[request.path.split("/")[8].to_i - 1]
            # Comment.where(user_id: request.path.split("/")[4]).sort[request.path.split("/")[8].to_i - 1]
          end
          post ":id/posts" do
            Post.create(user_id: request.path.split("/")[4], content: params[:content])
          end
          post ":id/posts/:post_id/comments" do
            post = Post.where(user_id: request.path.split("/")[4]).sort[request.path.split("/")[6].to_i - 1]
            Comment.create(user_id: request.path.split("/")[4], post_id: post[:id], content: params[:content])
          end
        end
      end
    end
  end
  