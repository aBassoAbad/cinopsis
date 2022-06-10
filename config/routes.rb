Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "peliculas#index"
  get 'peliculas/index', to: 'peliculas#index'

  get '/registro', to: 'usuarios#new'
  resources :lists
  resources :peliculas
  get '/series', to: 'series#index'
  get '/series_show/:id', to: 'series#show', as: "series_show"
  get '/buscar/:query', to: 'peliculas#buscar', as: "buscar"
  resources :usuarios, except: [:new]
  resources :usuarios do
    member do 
      post 'anadir_amigos'
      delete 'borrar_amigos'
    end
  end

  get '/amigos', to: 'friendships#index'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
end
