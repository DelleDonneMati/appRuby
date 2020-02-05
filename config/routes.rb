Rails.application.routes.draw do
  resources :tokens
  resources :solds
  resources :sells
  resources :sells, path: 'ventas', only: [:index]do
    collection do
      get :sell_user_id, path: '/:id'
    end
  end
  resources :reserveds
  resources :reservations
  resources :reservations, path: 'reservas' do
    collection do
      get :find_by_id, path: '/:id'
      put :to_sell, path: '/:id/vender'
      delete :delete_id, path: '/:id'
    end
  end
  resources :items
  resources :products
  resources :products, path: 'productos', only: [:index] do
    collection do
      get :find_by_unicode, path: '/:codigo'
      get :find_produts_in_items_with_unicode, path: '/:codigo/items'
    end
  end
  resources :users
  resources :phones
  resources :clients
  resources :types
  
  post '/usuarios', to: 'users#create'
  post '/sesiones', to: 'users#login'
 
  get '/authenticate', to: 'tokens#auth'
 
  post '/productos/:codigo/items', to: 'products#new_items_with_products'

  post '/reservas', to: 'reservations#create_reservation'

  post '/ventas', to: 'sells#new_sell'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
