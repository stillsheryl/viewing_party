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
  get '/movies/upcoming', to: 'movies#upcoming'
  get '/movies/top_rated', to: 'movies#top_rated'
  get '/movies/:movie_id', to: 'movies#show', as: :movie_show

  post '/friendships/new', to: 'friendships#create'

  get '/viewing-party/new', to: 'viewing_parties#new'
  post '/viewing-party/create', to: 'viewing_parties#create'
end
