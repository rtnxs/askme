Rails.application.routes.draw do
  get 'sessions/new'
  get 'sessions/create'
  get 'sessions/destroy'
  root 'users#index'

  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  resources :questions, except: [:show, :new, :index]
  resources :hashtags, only: [:show]

  get 'sign_up' => 'users#new'
  get 'log_out' => 'sessions#destroy'
  get 'log_in' => 'sessions#new'
end
