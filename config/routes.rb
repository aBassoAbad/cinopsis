Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "peliculas#index"
  get 'peliculas/index', to: 'peliculas#index'

  get '/registro', to: 'usuarios#new'
  get '/new_admin', to: 'usuarios#new_admin'
  post 'create_admin', to: 'usuarios#crear_admin'
  resources :lists
  get '/listas/:id', to: 'lists#listas', as: "listas"
  resources :peliculas
  get '/series', to: 'series#index'
  get '/series_show/:id', to: 'series#show', as: "series_show"
  get '/buscar/:query', to: 'buscar#buscar', as: "buscar"
  post '/anadir_a_lista', to: 'peliculas#anadir_a_lista'
  delete '/borrar_de_lista', to: 'peliculas#borrar_de_lista'
  post '/anadir_serie_a_lista', to: 'series#anadir_a_lista'
  delete '/borrar_serie_de_lista', to: 'series#borrar_de_lista'
  patch '/hacer_admin/:id', to: 'usuarios#hacer_admin', as: "hacer_admin"
  patch '/quitar_admin/:id', to: 'usuarios#quitar_admin', as: "quitar_admin"
  resources :usuarios, except: [:new]
  resources :usuarios do
    member do 
      post 'anadir_amigos'
      delete 'borrar_amigos'
    end
  end

  get '/amigos/:id', to: 'friendships#amigos', as: "amigos"

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
end
