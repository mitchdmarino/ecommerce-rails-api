Rails.application.routes.draw do

  resources :users
  post '/auth/login', to: 'authentication#login'
  post '/auth/register', to: 'authentication#register'

end
