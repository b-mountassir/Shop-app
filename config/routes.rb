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
  end
  get '/search', to: 'products#index'
  resources :products

  resources :order_items, only: %i(create update destroy)
  resources :orders, only: [:create]
  get '/cart', to: 'cart#show'

  get '/users', to: 'profile#show'

  delete '/empty_cart', to: 'order_items#destroy_all'
end
