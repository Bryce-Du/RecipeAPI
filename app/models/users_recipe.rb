class UsersRecipe < ApplicationRecord
  belongs_to :recipe
  belongs_to :user

  def makeable
    obj = {recipe_id: self.recipe_id, makeable: true, ingredients: []}
    pantry = self.user.users_ingredients # items the user has
    needed = self.recipe.recipes_ingredients # items the recipe requires 
    # call .ingredient on either of the above to access Ingredient instance, .quantity to access respective quantities
    needed.each do |recipe_ingr|
      if pantry_ingr = pantry.find{|user_ingr| user_ingr.ingredient_id == recipe_ingr.ingredient_id} # user has any of the item
        puts "found ingredient in user pantry"
        difference = pantry_ingr.quantity - recipe_ingr.quantity
        if difference < 0 # the recipe has more than the user, so not enough
          puts "   not enough in pantry"
          obj[:makeable] = false
          obj[:ingredients] << {attributes: IngredientSerializer.new(recipe_ingr.ingredient), needed: difference}
        elsif difference >= 0 # the user has enough, or more than enough
          puts "   user has enough"
          obj[:ingredients] << {attributes: IngredientSerializer.new(recipe_ingr.ingredient), remaining: difference}
        end
      else # user has none of the item
        puts "item not found in pantry"
        obj[:makeable] = false
        obj[:ingredients] << {attributes: IngredientSerializer.new(recipe_ingr.ingredient), needed: recipe_ingr.quantity}
      end
    end
    obj
  end
end
