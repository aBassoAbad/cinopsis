Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "paginas#home"
  get 'paginas/home', to: 'paginas#home'

  get '/registro', to: 'usuarios#new'
  resources :lists
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
