Rails.application.routes.draw do
  get 'sessions/login'
  resources :varieties
  resources :wines
  resources :reviews
  resources :users

  get '/', to: 'application#root'
  get '/login', to: 'sessions#login'
  post '/login', to: 'sessions#create'

  # Routes for Google authentication
  get 'auth/:provider/callback', to: 'sessions#googleAuth'
  get 'auth/failure', to: redirect('/')
end
