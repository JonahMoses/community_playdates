AuthorisationClient::Application.routes.draw do

  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'logout', to: 'sessions#destroy'
  get '/welcome', to: 'landing#index'
  resources :sessions
  root :to => "landing#index"

end
