Rails.application.routes.draw do

  get  'horses', to: 'users#horses'
  post 'horses', to: 'users#update_horses'

  post 'games/update', to: 'games#update'

  get 'admin/settings'

  get 'games/:id', to: 'games#show'

  get 'standings', to: 'users#table'

  get 'rules', to: 'static_pages#rules'

  post 'bets', to: 'bets#create'

  get 'games/group_stage/:group', to: 'games#group_stage'

  get 'games/knockout_stage/:phase', to: 'games#knockout_stage'

  get 'sessions/new'

  get  '/signup',  to: 'users#new'
  resources :users

  get    '/login',   to: 'sessions#new'

  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  root 'users#table'

end
