Rails.application.routes.draw do
  resources :challenges

  resources :teams

  resources :users

  resources :sessions, only: [:new, :create] do
    delete :destroy, on: :collection
  end

  root to: 'visitors#index'
end
