Rails.application.routes.draw do
  
  get 'sessions/new'

  get  '/signup',  to: 'users#new'
  resources :users

  get    '/login',   to: 'sessions#new'
  root 'sessions#new'

  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

end
