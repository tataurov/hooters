Rails.application.routes.draw do
  devise_for :users
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  root 'root#index'

  # Example of regular route:
  get 'gallery/:id' => 'gallery#index', as: :gallery
  resources :girls
  resource :categories, only: [:show]

end