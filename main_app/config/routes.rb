CommunityPlaydates::Application.routes.draw do

  get "/users/login" => "landing#index" # Don't Remove

  get "/logout" => "sessions#destroy"
  get "/welcome" => "landing#index"
  root :to => "dashboard#index"
  # get '/auth/facebook/callback' => root_path

  resources :users, only: [:index, :show]
  resources :events

  resources :registrations


end
