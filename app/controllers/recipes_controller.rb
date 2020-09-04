class RecipesController < ApplicationController
    before_action :get_user
    
    def index
        @recipes = (@user ? @user.recipes : Recipe.all)
        render json: RecipeSerializer.new(@recipes)
    end

    private

    def get_user
        @user = User.find(params[:user_id])
    end
end
