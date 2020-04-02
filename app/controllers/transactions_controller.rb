class TransactionsController < ApplicationController
    skip_before_action :verify_authenticity_token  
    
    def index
    end
    
    def new
        @groups = Group.find(params[:id])
        @transactions = Transaction.new
    end
    
    def show
        @transactions = Transaction.find(params[:id])
    end
    
    def create
        @groups = Group.find(params[:group_id])
        @transactions = @groups.transactions.create(transaction_params)
        
        render 'show'
    end
    
    def edit
        @groups = Group.find(params[:group_id])
        @transactions = @groups.transactions.find(params[:id])
    end
    
    def update
        @transaction = Transaction.find(params[:id])
    
        if @transaction.update(params.require(:transaction).permit(:id, :name, :amount, users_attributes:[:name]))
            redirect_to @transaction
        else
            render 'edit'
        end
    end
    
    def update_users
        @transaction = Transaction.find(params[:transaction_id])
        @user = User.find_by(name: params[:users][:name])
        @amounts = @user.amounts
        
        if((@user.in? @transaction.group.users) && (!@user.in? @transaction.users))
            @transaction.users << @user
        
            @paid = params[:users][:paid]
            @proportion = params[:users][:proportion]
            
            @difference = @paid.to_d - @proportion.to_d
            
            @amounts.find_by(transaction_id: @transaction.id).update_attributes(difference: @difference)
        end
        if @transaction.update(params.permit(:id, :name, :amount, users_attributes:[:name]))
            redirect_to @transaction
        else
            render 'edit'
        end
    end
    
    def destroy
        @groups = Group.find(params[:group_id])
        @transactions = @groups.transactions.find(params[:id])
        @transactions.destroy
        redirect_to group_path(@groups)
    end
    
    private
        def transaction_params
            params.require(:transaction).permit(:name, :amount, users_attributes:[:name])
        end
    
end
