module API
  module V1
    class Comments < Grape::API
      include API::V1::Defaults
      resource :comments do
        desc 'Return all comments'
        get '' do
          Comment.all
        end
        desc 'Return a comment'
        params do
          requires :id, type: String, desc: 'ID of the comment'
        end
        get ':id' do
          Comment.where(id: permitted_params[:id]).first!
        end
      end
    end
  end
end
