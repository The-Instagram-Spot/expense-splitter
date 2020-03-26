class TransactionsController < ApplicationController
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
        redirect_to transaction_path(@transactions)
    end
    
    def edit
        @groups = Group.find(params[:group_id])
        @transactions = @groups.transactions.find(params[:id])
    end
    
    def update
        @groups = Group.find(params[:group_id])
        @transactions = @groups.transactions.find(params[:id])
        @users = @transactions.users
    
        if @transactions.update(transaction_params)
            redirect_to @groups
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
            params.require(:transaction).permit(:name, :amount)
        end
    
end
