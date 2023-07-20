Rails.application.routes.draw do
  resources :cart_items
  resources :carts

  #resources :cart, only: [:show, :destroy]
 
   post '/add_to_cart', to: 'cart#add_to_cart', as: 'add_to_cart'


  resources :products
  #resources :carts

  # resources :product do
  #   resources :cart
  # end



  devise_for :users, controller: {
    registration: 'registration'
  }
  root 'products#index'
  
  
end
