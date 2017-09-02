Rails.application.routes.draw do
  root to: 'users#index'
  
  devise_for :users
  resources :users
  resources :friendships, only: [:create, :update, :destroy]
end
