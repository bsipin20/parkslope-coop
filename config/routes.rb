require 'sidekiq/web'

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  get "/producepricetimeline", to: "produce_price#index"
  mount Sidekiq::Web => '/sidekiq'
end
