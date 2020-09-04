class RecipeSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name, :instructions, :ingredients
end
