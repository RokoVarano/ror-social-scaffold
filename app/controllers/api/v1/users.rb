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
            User.where(user_id: @current_user[:id]).first!
          end
          get ":id/posts" do
            Post.where(user_id: @current_user[:id]).sort
          end
          post ":id/posts" do
            Post.create(user_id: @current_user[:id], content: params[:content])
          end
          get ":id/posts/:post_index" do
            Post.where(user_id: @current_user[:id]).sort[request.path.split("/")[6].to_i - 1]
          end
          get ":id/posts/:post_id/comments" do
            Comment.where(user_id: @current_user[:id]).where(post_id: request.path.split("/")[6]).sort
          end
          get ":id/posts/:post_id/comments" do
            Comment.create(user_id: @current_user[:id], post_id: request.path.split("/")[6], content: params[:content])
          end
          get ":id/posts/:post_id/comments/:comment_index" do
            Comment.where(user_id: @current_user[:id]).where(post_id: request.path.split("/")[6]).sort[request.path.split("/")[8].to_i - 1]
          end
        end
      end
    end
  end
  