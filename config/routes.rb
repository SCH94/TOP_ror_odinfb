Rails.application.routes.draw do
  resources :likes
  root to: 'users#index'
  
  devise_for :users
  
  resources :users
  resources :friendships, only: [:create, :update, :destroy]
  resources :posts do
    resources :likes, only: [:create, :destroy]
  end
end
