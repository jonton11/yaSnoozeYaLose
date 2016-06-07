Rails.application.routes.draw do
  resources :challenges do
    collection do
      get ':id/vote' => 'challenges#vote', as: :vote
    end
    resources :challenge_actions, only: [:update]
  end

  resources :teams do
    collection do
      get 'join'         => 'teams#join'
      get ':id/requests' => 'teams#team_requests', as: :request
    end
  end

  resources :users

  resources :sessions, only: [:new, :create] do
    delete :destroy, on: :collection
  end

  root to: 'visitors#index'
end
