class UserController < ApplicationController
    def new
        @users = User.new
    end
    
    def create
        @user = User.new(user_params)
        if @groups.save
            redirect_to @groups
        else
            render 'new'
        end
    end
    
    private
        def user_params
            params.require(:email).permit(:encrypted_password)
        end
    
end
