UserClient::Application.routes.draw do
  post 'users' => 'users#create'
  get 'users/:id' => 'users#show'
  get 'users/:id/friends' => 'users#friends'
  get 'users/:id/all-friend-data' => 'users#all_friend_data'
  resources :friendships
end
