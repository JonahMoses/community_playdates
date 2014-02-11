RegistrationClient::Application.routes.draw do

  post '/registrations' => "registrations#create"
  get '/registrations/roles/:id/:event_id' => "registrations#role_registrations"
  get '/registrations/users/:id' => "registrations#user_registrations"
end
