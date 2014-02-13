AuthorisationClient::Application.routes.draw do

  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'logout', to: 'sessions#destroy'
  resources :sessions
  root :to => "landing#index"
  get '/welcome', to: redirect('/')

end
