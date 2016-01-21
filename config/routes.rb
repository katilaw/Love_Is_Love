Rails.application.routes.draw do
  devise_for :users

  root 'stories#index'
  resources :stories, only: [
    :index, :new, :create, :edit, :update, :show, :destroy
  ]

  resources :stories, only: [:show] do
    resources :comments, only: [:new, :edit, :update, :create, :destroy]
  end
end
