Rails.application.routes.draw do
  
  get  'horses', to: 'users#horses'
  post 'horses', to: 'users#update_horses'

  resources :games
  post 'games/update', to: 'games#update'

  get 'admin/settings'

  get 'games/:game_id', to: 'games#bets'

  get 'the_table', to: 'users#table'
  
  get 'the_rules', to: 'static_pages#the_rules'

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
