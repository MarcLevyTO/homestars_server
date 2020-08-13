Rails.application.routes.draw do
  post "/login", to: "users#login"
  get "/profile", to: "users#profile"
  get "/gifSearch", to: "gif_search#search"
  get "/search", to: "search#search"
  get "/messages/search", to: "messages#search"
  post "/channels/:id/join", to: "channels#join"
  get "/stats", to: "statistics#get_stats"

  resources :users, only: [:index, :create]
  resources :channels, only: [:index, :create, :show]
  resources :messages, only: [:index, :create, :update]
  # mount ActionCable.server => '/cable'
end
