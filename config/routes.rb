Rails.application.routes.draw do
  resources :comments
  devise_for :users
   resources :links do
    member do
      put "like", to:    "links#upvote"
      put "dislike", to: "links#downvote"
    end
   resources :comments
end
  root to: "links#index"
  get '/links/:id/d3_data', to: 'd3_data#d3_data', as: 'd3_data'
  get '/analyze/:id', to: 'links#analyze'


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
