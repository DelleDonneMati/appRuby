Rails.application.routes.draw do
  resources :tokens
  resources :solds
  resources :sells
  resources :reserveds
  resources :reservations
  resources :items
  resources :products
  resources :users
  resources :phones
  resources :clients
  resources :types
  # root 'application#hello'
  post '/usuarios', to: 'users#create'
  post '/sesiones', to: 'users#login'
  get '/productos', to: 'products#giveMeProducts'
  get '/productos/:codigo', to: 'products#codProd'
  get '/productos/:codigo/items', to: 'products#prodWithCodeInItems'
  post '/productos/:codigo/items', to: 'products#prodWithItems'
  get '/reservas', to: 'reservations#reserv'
  get '/reservas/:id', to: 'reservations#reservId'
  post '/reservas', to: 'reservations#create'
  # Probar los parametros de los get desde curl, con curl -x get -d 'parametro'
  # Los post para crear, estan en el croud ya creados post /products
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
