class User < ApplicationRecord
    has_many :users_ingredients
    has_many :ingredients, through: :users_ingredients
    has_many :users_recipes
    has_many :recipes, through: :users_recipes
end
