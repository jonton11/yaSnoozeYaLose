Rails.application.routes.draw do
  resources :challenges do
    resources :challenge_actions, only: [:create, :update, :destroy]
  end

  # Can we refactor this? teams/teams/join is gross
  resources :teams do
    collection do
      get 'teams/join' => 'teams#join'
    end
  end

  resources :users

  resources :sessions, only: [:new, :create] do
    delete :destroy, on: :collection
  end

  root to: 'visitors#index'
end
