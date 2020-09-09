class RecipesIngredient < ApplicationRecord
  belongs_to :recipe, touch: true
  belongs_to :ingredient, touch: true
end
