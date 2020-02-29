class TransactionsController < ApplicationController
    def create
        @groups = Group.find(params[:group_id])
        @transactions = @groups.transactions.create(transaction_params)
        redirect_to group_path(@groups)
    end
    
    def edit
        @groups = Group.find(params[:group_id])
        @transactions = @groups.transactions.find(params[:id])
    end
    
    def update
        @groups = Group.find(params[:group_id])
        @transactions = @groups.transactions.find(params[:id])
    
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
            params.require(:transaction).permit(:p1_id, :p2_id, :amount)
        end
    
end
