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
        
        redirect_to group_path(@groups)
    end
    
    def edit
        @groups = Group.find(params[:group_id])
        @transactions = @groups.transactions.find(params[:id])
    end
    
    def update
        @groups = Group.find(params[:group_id])
        @transactions = @groups.transactions.find(params[:id])
        
        #@transaction = Transaction.find(params[:id])
        
        #@user = User.find_by(name: params[:users][:name])
        #@transaction.users << @user
        
    
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
            params.require(:transaction).permit(:name, :amount, users_attributes:[:name])
        end
    
end
