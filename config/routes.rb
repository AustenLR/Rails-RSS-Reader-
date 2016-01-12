Rails.application.routes.draw do
  root 'articles#index'
  get '/favorites', to: 'articles#favorites'
  resources :articles, only: [:index, :create]
end
