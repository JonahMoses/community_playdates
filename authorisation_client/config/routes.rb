AuthorisationClient::Application.routes.draw do

  root :to => "landing#index"
  resources :sessions
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: 'signout'

end
