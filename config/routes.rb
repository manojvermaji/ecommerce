Rails.application.routes.draw do
  resources :cart_item
  # get '/index', to: 'cart_item#index', as: 'index'
  
 

   post '/add_to_cart', to: 'cart#add_to_cart', as: 'add_to_cart'
   get '/show_cart_items', to: 'cart#show_cart_items'


  resources :products
  resources :cart

  devise_for :users, controller: {
    registration: 'registration'
  }
  root 'products#index'
  
  
end
