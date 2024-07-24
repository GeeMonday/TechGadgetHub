Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }
  root 'home#index' # Sets the home page

  resources :products, only: [:index, :show]
  resources :categories, only: [:index, :show]
  resources :static_pages, only: [:show], param: :title
  resource :cart, only: [:show] do
    post 'add_to_cart', on: :collection
    patch 'update', on: :collection
    delete 'remove', on: :collection
    get 'checkout', on: :collection
    post 'complete_checkout', on: :collection
  end

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Static pages route (if applicable)
  get 'static_pages/show'
end
