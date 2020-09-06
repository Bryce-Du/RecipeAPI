class RecipesController < ApplicationController
    before_action :get_user 
    
    def index
        @recipes = (@user ? @user.recipes : Recipe.all)
        render json: RecipeSerializer.new(@recipes)
    end

    def create
        @recipe = Recipe.new(recipe_params)
        if @recipe.save
            params[:ingredients].each do |ingr|
                ingredient = Ingredient.find_by(name: ingr[:name])
                RecipesIngredient.create(recipe_id: @recipe.id, ingredient_id: ingredient.id, quantity: ingr[:quantity])
            end
            UsersRecipe.create(user_id: @user.id, recipe_id: @recipe.id)
            render json: RecipeSerializer.new(@recipe)
        else
            render json: { error: 'failed to create recipe' }, status: :not_acceptable
        end
        byebug
    end

    private

    def recipe_params
        params.require(:recipe).permit(:name, :instructions)
    end
    def get_user
        @user = User.find(params[:user_id])
    end
end
