Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#index'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  get '/dashboard', to: 'dashboard#index'

  get '/registration', to: 'users#new'
  post '/users', to: 'users#create'

  get '/discover', to: 'dashboard#discover'

  get '/movies', to: 'movies#index'
  get '/movies/top_rated', to: 'movies#top_rated'
  get '/movies/:movie_id', to: 'movies#show'

  post '/friendships/new', to: 'friendships#create'
end
