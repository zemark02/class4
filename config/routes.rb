Rails.application.routes.draw do
  resources :posts
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get "create_fast" ,to: "users#create_fast"
  get "destroy_all" ,to: "users#destroy_all"
  get "main" ,to: "users#main"
  post "main" ,to: "users#login"
end
