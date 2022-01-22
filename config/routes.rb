Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations'}
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'categories#index'
  resources :categories do 
    resources :products
  end

  namespace :admin do
    resources :categories
  end
  namespace :seller do
    resources :products
  end
end
