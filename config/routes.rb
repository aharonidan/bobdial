Rails.application.routes.draw do
  
  get 'games/group_stage/:group', to: 'games#group_stage'

  get 'games/round_of_16'

  get 'games/quarter_finals'

  get 'games/semi_finals'

  get 'games/final'

  get 'sessions/new'

  get  '/signup',  to: 'users#new'
  resources :users

  get    '/login',   to: 'sessions#new'
  root 'sessions#new'

  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

end
