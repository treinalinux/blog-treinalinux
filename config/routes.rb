Rails.application.routes.draw do
  resources :authors
  get 'site', to: 'site#index'
  root to: 'site#index'
  resources :posts
end
