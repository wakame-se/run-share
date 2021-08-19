Rails.application.routes.draw do
  devise_for :users
  root to: 'posts#index'
  resources :posts, only: %i[new create edit update]
  resources :users, only: %i[show edit update]
end
