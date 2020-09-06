class IngredientsController < ApplicationController
    before_action :get_user
    
    def index
        @ingredients = (@user ? @user.ingredients : Ingredient.all)
        render json: IngredientSerializer.new(@ingredients)
    end

    private
    def get_user
        @user = User.find_by(id: params[:user_id])
    end
end