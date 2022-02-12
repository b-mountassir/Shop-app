require 'sidekiq/web'

Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations'}
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'categories#home'
  resources :categories do 
    resources :products
  end

  namespace :admin do
    resources :categories
    get "/dashboard", to: 'dashboard#index'
  end

  namespace :seller do
    resources :products
    get "/dashboard", to: 'dashboard#index'
  end
  get '/search', to: 'products#index'
  resources :products

  resources :order_items, only: %i(create update destroy)
  resources :orders, only: %i(create show index)
  get '/cart', to: 'cart#show'

  get '/users', to: 'profile#show'

  delete '/empty_cart', to: 'order_items#destroy_all'

  resources :reviews, only: %i(create update destroy) 
   
  post 'reviews_from_email', to: 'reviews#create_from_email'
  get '/reviews', to: 'reviews#new'

  mount Sidekiq::Web => '/sidekiq'


end
