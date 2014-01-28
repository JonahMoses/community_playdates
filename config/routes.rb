CommunityPlaydates::Application.routes.draw do

  get "/users/login" => "landing#index" # Don't Remove

  devise_for :users, path_names: {sign_in: "login", sign_out: "logout"},
                   controllers: {omniauth_callbacks: "omniauth_callbacks"}

  
  root :to => "landing#index"

end
