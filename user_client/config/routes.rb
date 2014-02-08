UserClient::Application.routes.draw do
  post 'users' => 'users#create'
  get 'users/:id' => 'users#show'
  get 'users/:id/friends' => 'users#friends'
end
