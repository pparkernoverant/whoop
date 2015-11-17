Rails.application.routes.draw do
  root to: 'businesses#index'

  get '/login', to: 'sessions#new'
  get '/logout', to: 'sessions#destroy'
  get '/register', to: 'users#new'

  post '/login', to: 'sessions#create'

  resources :businesses, only: [:show, :create, :new] do
    resources :reviews, only: [:create]
  end

  resources :users, only: [:show, :create, :edit, :update]
  resources :session, only: [:create]
end
