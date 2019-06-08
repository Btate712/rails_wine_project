Rails.application.routes.draw do
  get 'sessions/login'
  get 'varieties/popular', to: 'varieties#popular'
  
  resources :varieties
  resources :wines do
    resources :reviews, only: [:index, :show, :new]
  end
  resources :reviews
  resources :users do
    resources :reviews, only: [:index, :show]
  end

  root 'application#root'

  get '/login', to: 'sessions#login'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  # Routes for Google authentication
  get 'auth/:provider/callback', to: 'sessions#googleAuth'
  get 'auth/failure', to: redirect('/')


end
