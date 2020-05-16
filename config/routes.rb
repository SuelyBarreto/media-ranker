Rails.application.routes.draw do
  get 'homepages/index'
  root 'homepages#index'

  resources :works
  get "/works/:id/upvote", to: "works#upvote", as: :upvote_work
end
