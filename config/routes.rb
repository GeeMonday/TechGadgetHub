Rails.application.routes.draw do
  # Devise routes for user authentication
  devise_for :users, controllers: { registrations: 'users/registrations' }

  # Devise routes for admin authentication
  devise_for :admin_users, ActiveAdmin::Devise.config

  # Root path
  root 'home#index' # Sets the home page

  # Resources routes
  resources :products, only: [:index, :show]
  resources :categories, only: [:index, :show]
  resources :static_pages, only: [:show], param: :title
  resources :orders, only: [:show] 

  # Cart routes
  resource :cart, only: [:show, :update] do
    post 'add_to_cart'
    delete 'remove/:id', to: 'carts#remove', as: :remove
    get 'checkout'
    get 'order_confirmation/:id', to: 'orders#confirmation', as: :order_confirmation
    post 'complete_checkout'
  end

  # ActiveAdmin routes
  ActiveAdmin.routes(self)

  # Health check route
  get "up" => "rails/health#show", as: :rails_health_check

  # Static pages route (if applicable)
  get 'static_pages/show'
end
