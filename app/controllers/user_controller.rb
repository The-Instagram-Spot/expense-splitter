class UserController < ApplicationController
    def new
        @users = User.new
    end
    
    def edit
        @groups = Group.find(params[:group_id])
        @users = @groups.users
    end
    
    def create
        @user = User.new(user_params)
        if @user.save
            redirect_to @groups
        else
            render 'new'
        end
    end
    
    def update
        @groups = Group.find(params[:group_id])
        @users = @groups.users
        
        if @users.update(user_params)
          redirect_to @groups
        else
          render 'edit'
        end
    end
    
    private
        def user_params
            params.require(:user).permit(:email)
        end
    
end
