class Recipe < ApplicationRecord
    has_many :recipes_ingredients, dependent: :destroy
    has_many :ingredients, through: :recipes_ingredients
    has_many :users_recipes, dependent: :destroy
    has_many :users, through: :users_recipes
end
