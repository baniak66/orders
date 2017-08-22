Rails.application.routes.draw do
  root "pages#app"
  get '/auth/:provider/callback', to: 'sessions#create'
  get '/user', to: 'users#status'
end
