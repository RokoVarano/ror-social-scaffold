Rails.application.routes.draw do

  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  root 'posts#index'

  devise_for :users,
             controllers: {
                 sessions: 'users/sessions',
                 registrations: 'users/registrations'
             }

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
