class AddQuantityToRecipesIngredients < ActiveRecord::Migration[6.0]
  def change
    add_column :recipes_ingredients, :quantity, :integer
  end
end
