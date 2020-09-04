Rails.application.routes.draw do
  resources :users, only: [:create]
  post '/login', to: 'session#create'
  resources :recipes
  resources :ingredients
  resources :users do
    resources :recipes, only: [:index]
    resources :ingredients, only: [:index]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
