Rails.application.routes.draw do
  post "/login", to: "users#login"
  get "/profile", to: "users#profile"
  get "/gifSearch", to: "gif_search#search"
  get "/search", to: "search#search"

  resources :users, only: [:index, :create]
  resources :channels, only: [:index, :create]
  resources :messages, only: [:index, :create]
  mount ActionCable.server => '/cable'
end
