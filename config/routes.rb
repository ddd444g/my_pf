Rails.application.routes.draw do
  resources :spots
  resources :users
  root to: 'users#index'
end
