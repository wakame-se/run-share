Rails.application.routes.draw do
  devise_for :users
  root to: 'posts#top'
  resources :posts do
    resource :likes, only: %i[create destroy]
    resources :comments, only: %i[create destroy]
  end
  resources :users, only: %i[show edit update]
end
