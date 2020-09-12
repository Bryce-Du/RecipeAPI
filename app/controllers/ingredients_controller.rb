class IngredientsController < ApplicationController
    before_action :get_user
    
    def index
        @ingredients = (@user ? @user.ingredients : Ingredient.all.limit(20))
        render json: IngredientSerializer.new(@ingredients)
    end

    def search
        @ingredients = Ingredient.search(params[:searchTerm])
        render json: IngredientSerializer.new(@ingredients)
    end

    private
    def get_user
        @user = User.find_by(id: params[:user_id])
    end
end