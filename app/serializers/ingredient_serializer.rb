class IngredientSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name, :calories, :users_ingredients, :description
end
