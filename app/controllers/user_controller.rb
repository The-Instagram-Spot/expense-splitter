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
    
    def destroy_from_transaction
        @users = User.find(params[:user_id])
        @transactions = Transaction.find(params[:id])
        
        @users.transactions.delete(@transactions)
        @transactions.users.delete(@users)
        
        redirect_to @transactions
        
    end
    
    def settle_up
       @user = User.find(params[:user_id])
       @group = Group.find(params[:group_id])
       @amounts = @user.amounts
       
      
       render 'settle_up'
    end
    
    def destroy
        @group = Group.find(params[:id])
        @user = User.find(params[:group_id])
        
        @group.users.delete(@user)
        @user.groups.delete(@group)
        
       redirect_to @group
        
    end
    
    private
        def user_params
            params.require(:user).permit(:email)
        end
    
end
