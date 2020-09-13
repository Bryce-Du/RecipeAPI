Rails.application.routes.draw do
  resources :users, only: [:create]
  post '/login', to: 'session#create'
  resources :recipes
  resources :ingredients
  get '/ingredients/search/:searchTerm', to: 'ingredients#search'
  resources :users do
    resources :recipes, only: [:index, :create, :update, :destroy]
    resources :ingredients, only: [:index]
    resources :users_ingredients, only: [:create]
  end
  get '/users/:user_id/recipes/makeable', to: 'users_recipes#makeable'
  post '/users/:user_id/recipes/:recipe_id/make', to: 'users_recipes#make'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
