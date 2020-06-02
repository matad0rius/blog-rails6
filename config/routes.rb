Rails.application.routes.draw do
  root 'pages#home'
  get 'about', to: 'pages#about'
  # resources :articles, only: [:show, :index, :new, :create, :edit, :update, :destroy]
  resources :articles

  get 'signup', to 'user#new'
  post 'users', to 'user#create'
  resources :users, except: { :new }
end
