Rails.application.routes.draw do
  resources :tokens
  resources :solds
  resources :sells, path: 'ventas', only: [:index]do
    collection do
      get :sell_user_id, path: '/:id'
      post :new_sell
    end
  end
  resources :reserveds
  resources :reservations, path: 'reservas', only: [:index] do
    collection do
      get :find_by_id, path: '/:id'
      # post :create_reservation
      put :to_sell, path: '/:id/vender'
      delete :delete_id, path: '/:id'
    end
  end
  resources :items
  resources :products, path: 'productos', only: [:index] do
    collection do
      get :find_by_unicode, path: '/:codigo'
      get :find_produts_in_items_with_unicode, path: '/:codigo/items'
      # post :new_items_with_products, path: '/:codigo/items'
    end
  end
  resources :users
  resources :phones
  resources :clients
  resources :types
  
  post '/usuarios', to: 'users#create'
  post '/sesiones', to: 'users#login'
 
  get '/authenticate', to: 'tokens#auth'
 

  # get '/productos', to: 'products#giveMeProducts'
  # get '/productos/:codigo', to: 'products#codProd'
  # get '/productos/:codigo/items', to: 'products#prodWithCodeInItems'
  post '/productos/:codigo/items', to: 'products#createItemsWithProd'
  
  # get '/reservas', to: 'reservations#reservNotSold'
  # get '/reservas/:id', to: 'reservations#reservId'
  post '/reservas', to: 'reservations#create_reservation'
  # put '/reservas/:id/vender', to: 'reservations#to_sell'
  # delete '/reservas/:id', to:'reservations#delete_id'

  # get '/ventas', to: 'sells#user_sales'
  # get '/ventas/:id', to: 'sells#sellUser'
  post '/ventas', to: 'sells#newSell'

   
  # Probar los parametros de los get desde curl, con curl -x get -d 'parametro'
  # Los post para crear, estan en el croud ya creados post /products
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
