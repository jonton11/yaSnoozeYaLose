Rails.application.routes.draw do
  resources :challenges do
    collection do
      get ':id/vote' => 'challenges#vote', as: :vote
    end
    resources :acceptings, only: [] do
      patch :update, on: :collection
    end
    resources :rejectings, only: [] do
      patch :update, on: :collection
    end
    resources :challenge_actions, only: [:update], as: :update_actions
  end

  resources :teams do
    collection do
      get 'join'         => 'teams#join'
      post 'join'        => 'teams#join'
      get ':id/requests' => 'teams#team_requests', as: :request
    end
  end

  resources :users

  resources :sessions, only: [:new, :create] do
    delete :destroy, on: :collection
  end

  get '/auth/twitter', as: :sign_in_with_twitter
  get '/auth/twitter/callback' => 'callbacks#twitter'

  get '/auth/facebook', as: :sign_in_with_facebook
  get '/auth/facebook/callback' => 'callbacks#facebook'

  root to: 'visitors#index'
end
