class UsersRecipesController < ApplicationController
    before_action :get_user
    
    def makeable
        makeable_array = @user.users_recipes.map{|ur| ur.makeable}.filter{|make_obj| make_obj[:makeable]}
        render json: makeable_array
    end
    def make 
    end

    private
    def get_user
        @user = User.find_by(id: params[:user_id])
    end
end
