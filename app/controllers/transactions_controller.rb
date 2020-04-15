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
        @transactions = Transaction.find(params[:transaction_id])
        @user = User.find_by(name: params[:users][:name])
        @amounts = @user.amounts
        
        @paid = params[:users][:paid]
        @proportion = params[:users][:proportion]
            
        if((@proportion.to_d > @transactions.amount) || (@paid.to_d > @transactions.amount)) #check if proportion or paid is higher than total
            render 'show'
        else
            flash.discard
            if((@user.in? @transactions.group.users) && (!@user.in? @transactions.users)) #check if user is in the group and not already in the transaction
                @transactions.users << @user
                @difference = @paid.to_d - @proportion.to_d
                @amounts.find_by(transaction_id: @transactions.id).update_attributes(difference: @difference, paid: @paid)
            end
            
            if @transactions.update(params.permit(:id, :name, :amount, users_attributes:[:name]))
                redirect_to @transactions
            else
                render 'edit'
            end
        end
    end
    
    def destroy
        @groups = Group.find(params[:group_id])
        @transactions = @groups.transactions.find(params[:id])
        
        @transactions.amounts.destroy
        
        @transactions.destroy
        redirect_to group_path(@groups)
    end
    
    private
        def transaction_params
            params.require(:transaction).permit(:name, :amount, users_attributes:[:name])
        end
    
end
