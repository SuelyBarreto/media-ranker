Rails.application.routes.draw do
  get 'homepages/index'
  root 'homepages#index'

  resources :works
  get "/works/:id/upvote", to: "works#upvote", as: :upvote_work

  get "/users", to: "users#index", as: :users
  get "/users/:id", to: "users#show", as: :user
  get "/login", to: "users#login_form", as: "login"
  post "/login", to: "users#login"
  post "/logout", to: "users#logout", as: "logout"
end
