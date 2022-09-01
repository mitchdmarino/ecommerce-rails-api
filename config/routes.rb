Rails.application.routes.draw do

  resources :users
  resources :products
  resources :orders
  post '/auth/login', to: 'authentication#login'
  post '/auth/register', to: 'authentication#register'

end
