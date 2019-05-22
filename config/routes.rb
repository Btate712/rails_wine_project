Rails.application.routes.draw do
  get 'sessions/login'
  resources :varieties
  resources :wines
  resources :reviews
  resources :users

  get '/', to: 'application#root'
  get '/login', to: 'sessions#login'
  post '/login', to: 'sessions#create'
end
