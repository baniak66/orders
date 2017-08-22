Rails.application.routes.draw do
  root "pages#app"
  get '/auth/:provider/callback', to: 'sessions#create'
end
