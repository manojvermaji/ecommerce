Rails.application.routes.draw do
  get 'order/index'
  get 'cart/index'
 
  resources :products
  resources :carts



  devise_for :users, controller: {
    registration: 'registration'
  }
  root 'products#index'
  
  
end
