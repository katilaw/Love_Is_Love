Rails.application.routes.draw do
  devise_for :users

  root 'stories#index'
  resources :stories, only: [:index, :new, :create, :edit, :update, :show, :destroy]
  # resources :lifehacks, only: [:index, :new, :create, :destroy]
end
