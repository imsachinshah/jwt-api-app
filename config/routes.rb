require 'sidekiq/web' 
require 'sidekiq/cron/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq' 
  get "/notifications", to: "notifications#index"

  resources :users, :posts

  post '/auth/login', to: 'authentication#login'
end
