class CreateUsersIngredients < ActiveRecord::Migration[6.0]
  def change
    create_table :users_ingredients do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :ingredient, null: false, foreign_key: true

      t.timestamps
    end
  end
end
