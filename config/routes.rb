Rails.application.routes.draw do

  get 'reports', to: 'reports#index'
  get 'reports/:id', to:'reports#show'
  post 'reports', to: 'reports#create'


  get  'special_bets/my', to: 'users#my_bets'
  get  'special_bets/all', to: 'users#all_bets'
  post 'horses', to: 'users#update_horses'

  post 'games/update', to: 'games#update'

  delete 'admin/horses/:id', to: 'admin#delete'
  delete 'admin/reports/:id', to: 'admin#delete_report'

  post 'admin/horses', to: 'admin#create'
  get 'admin/horses'

  get 'admin/reports'
  get 'admin/settings'

  get 'games/:id', to: 'games#show'
  get 'games/:id/stats', to: 'games#stats'

  get 'standings/:tab', to: 'users#standings'

  get 'rules', to: 'static_pages#rules'
  get 'unauthorized', to: 'static_pages#unauthorized'

  post 'bets', to: 'bets#create'

  get 'games/group_stage/:group', to: 'games#group_stage'

  get 'games/knockout_stage/:phase', to: 'games#knockout_stage'

  get 'sessions/new'

  get  '/signup',  to: 'users#set_account'
  get  '/users/new',  to: 'users#new'

  post '/users', to: 'users#create'

  get    '/login',   to: 'sessions#new'

  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  root to: 'users#standings', tab: 'points'
end
