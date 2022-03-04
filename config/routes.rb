require 'sidekiq/web'

Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations'}
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'categories#home'
  resources :categories do 
    resources :products do
      collection do
        match 'search' => 'prdocuts#search', via: [:get, :post], as: :search
      end
    end
  end

  namespace :admin do
    resources :categories
    get "/dashboard", to: 'dashboard#index'
  end

  namespace :seller do
    resources :products
    get "/dashboard", to: 'dashboard#index'
    get "/dashboard/orders", to: 'dashboard#show'
  end
  get '/search', to: 'products#index'
  resources :products do
    collection do
      match 'search' => 'products#search', via: [:get, :post], as: :search
    end
  end

  resources :order_items, only: %i(create update destroy)
  resources :orders, only: %i(create show index)
  get '/cart', to: 'cart#show'

  get '/users/:username', to: 'profile#show', as: 'user'

  delete '/empty_cart', to: 'order_items#destroy_all'

  resources :reviews, only: %i(create edit update destroy) 
   
  post 'reviews_from_email', to: 'reviews#create_from_email'
  get '/reviews', to: 'reviews#new'

  mount Sidekiq::Web => '/sidekiq'


end
