Rails.application.routes.draw do
  root "pages#app"
  get '/auth/:provider/callback', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/user', to: 'users#status'
end
