Rails.application.routes.draw do
  devise_for :users
  resources :links

  root to: "links#index"
  get '/links/:id/d3_data', to: 'd3_data#d3_data', as: 'd3_data'

  get '/analyze/:id', to: 'links#analyze'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
