class RecipesController < ApplicationController
    before_action :get_user 
    
    def index
        @recipes = (@user ? @user.recipes : Recipe.all)
        render json: RecipeSerializer.new(@recipes)
    end

    def create
        @recipe = Recipe.new(name: recipe_params[:name], instructions: recipe_params[:instructions])
        if @recipe.save
            recipe_params[:ingredients].each do |ingr|
                ingredient = Ingredient.find_by(name: ingr[:name])
                RecipesIngredient.create(recipe_id: @recipe.id, ingredient_id: ingredient.id, quantity: ingr[:quantity]) if ingredient
            end
            UsersRecipe.create(user_id: @user.id, recipe_id: @recipe.id)
            render json: RecipeSerializer.new(@recipe)
        else
            render json: { error: 'failed to create recipe' }, status: :not_acceptable
        end
    end

    def update
        @recipe = Recipe.find(params[:id])
        @recipe.name = recipe_params[:name]
        @recipe.instructions = recipe_params[:instructions]
        @recipe.ingredients = [] # remove all old ingredients
        recipe_params[:ingredients].each do |ingr|
            ingredient = Ingredient.find_by(name: ingr[:name]) # then add new ones back in
            @recipe.ingredients.push(ingredient)
            @recipe.recipes_ingredients.last.update(quantity: ingr[:quantity])
        end
        if @recipe.save
            render json: RecipeSerializer.new(@recipe)
        else
            render json: { error: 'failed to create recipe' }, status: :not_acceptable
        end
    end

    private

    def recipe_params
        params.require(:recipe).permit(:name, :instructions, :ingredients => [:name, :quantity])
    end
    def get_user
        @user = User.find(params[:user_id])
    end
end
