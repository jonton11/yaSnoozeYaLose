Rails.application.routes.draw do
  resources :challenges do
    resources :challenge_actions, only: [:update]
  end

  resources :teams do
    collection do
      get 'join' => 'teams#join'
    end
  end

  resources :users

  resources :sessions, only: [:new, :create] do
    delete :destroy, on: :collection
  end

  root to: 'visitors#index'
end
