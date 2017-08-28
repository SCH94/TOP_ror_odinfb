Rails.application.routes.draw do
  get 'friendships/create'

  get 'friendships/destroy'

  root to: 'users#index'
  
  devise_for :users
  resources :users
end
