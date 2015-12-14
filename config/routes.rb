Rails.application.routes.draw do
  devise_for :users
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  root 'root#index'
  get '/robots.txt' => 'root#robots'

  get 'gallery/:id' => 'gallery#index', as: :gallery
  resources :girls, only: [:index, :show]
  resource :categories, only: [:show]
end