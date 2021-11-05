Rails.application.routes.draw do

  root 'posts#index'

  namespace :api,  defaults: {format: 'json'} do
    namespace :v1 do
      resources :users, only: [:index, :show] do
        resources :posts, only: [:index, :show, :create] do
          resources :comments, only: [:index, :show, :create]
        end
      end
    end
  end

  devise_for :users

  resources :users, only: [:index, :show] do
    get 'friendships', to: 'friendships#index', as: 'friendships'
    post 'friendship/:id', to: 'friendships#create', as: :add_friend
  end

  get 'confirm_request/:id', to: 'friendships#confirm_request', as: :confirm_request
  get 'reject_request/:id', to: 'friendships#reject_request', as: :reject_request
  get 'pending_friends', to: 'friendships#pending_friends', as: :pending_friends
  resources :posts, only: [:index, :create] do
    resources :comments, only: [:create]
    resources :likes, only: [:create, :destroy]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
