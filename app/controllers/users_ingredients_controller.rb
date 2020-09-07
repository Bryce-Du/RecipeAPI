class UsersIngredientsController < ApplicationController
    before_action :get_user
    def create
        user_ingredient_params[:ingredients].each do |ingredient| # for every ingredient submitted
            user_ingredient = @user.users_ingredients.find_by(ingredient_id: ingredient[:id]) 
            if user_ingredient # does the user have this item in their pantry already
                user_ingredient.quantity += ingredient[:quantity].to_i
            else
                user_ingredient = UsersIngredient.create(ingredient_id: ingredient[:id], user_id: @user.id, quantity: ingredient[:quantity])
            end
        end
        render json: IngredientSerializer.new(@user.ingredients)
    end
    private
    def get_user
        @user = User.find_by(id: params[:user_id])
    end

    def user_ingredient_params
        params.permit({:ingredients => [:id, :quantity]}, :user_id)
    end

end
