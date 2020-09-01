class Recipe < ApplicationRecord
    has_many :recipes_ingredients
    has_many :ingredients, through: :recipes_ingredients
    has_many :users_recipes
    has_many :users, through: users_recipes
end
