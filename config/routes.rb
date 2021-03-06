Rails.application.routes.draw do
  resources :comments
  
  devise_for :users, controllers: { 
    omniauth_callbacks: "users/omniauth_callbacks" }

  devise_scope :user do
    authenticated :user do
      root :to => 'posts#index', as: :authenticated_root
    end
    unauthenticated do
      root :to => 'devise/sessions#new', as: :unauthenticated_root
    end
  end
  
  resources :users

  resources :friendships, only: [:create, :update, :destroy]
  get 'friendships/:id', to: 'friendships#decline'
  
  resources :posts do
    resources :likes, only: [:create, :destroy]
    resources :comments
  end
end
