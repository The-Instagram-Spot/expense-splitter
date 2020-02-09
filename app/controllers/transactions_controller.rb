class TransactionsController < ApplicationController
    def show
        @transactions = Transaction.find(params[:id])
    end
    
    def new
        @transactions = Transaction.new
    end
    
    def create
        @groups = Group.find(params[:group_id])
        @transactions = @groups.transactions.create(transaction_params)
        redirect_to group_path(@groups)
        
       # @transactions.save
        #    redirect_to @transactions
        
    end
    
    def destroy
        @groups = Group.find(params[:group_id])
        @transactions = @groups.transcations.find(params[:id])
        @transactions.destroy
        redirect_to group_path(@groups)
    end
    
    private
        def transaction_params
            params.require(:transaction).permit(:p1_id, :p2_id, :amount)
        end
    
end
