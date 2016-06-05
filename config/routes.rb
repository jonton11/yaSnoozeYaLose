Rails.application.routes.draw do
  resources :challenges do
    resources :challenge_actions, only: [:create, :update, :destroy]
  end

  resources :teams

  resources :users

  resources :sessions, only: [:new, :create] do
    delete :destroy, on: :collection
  end

  root to: 'visitors#index'
end
