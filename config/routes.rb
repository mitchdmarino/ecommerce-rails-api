Rails.application.routes.draw do

  resources :users
  resources :products
  post '/auth/login', to: 'authentication#login'
  post '/auth/register', to: 'authentication#register'

end
