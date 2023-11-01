Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  get "/notifications", to: "notifications#index"
  
  resources :users, :posts

  post '/auth/login', to: 'authentication#login'
end
