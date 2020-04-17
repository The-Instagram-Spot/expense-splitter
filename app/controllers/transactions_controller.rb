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
        if(@user.nil?)
            @transactions.errors[:base] << "This user does not exist"
            render 'show'
            return 
        end
        @amounts = @user.amounts
        
        @paid = params[:users][:paid]
        @proportion = params[:users][:proportion]
            
        if(@proportion.to_d > @transactions.amount) #check if proportion is higher than total
            @transactions.errors[:base] << "Expected amount cannot be more than transaction total"
            render 'show'
            return
        elsif(@paid.to_d > @transactions.amount) #check if paid is higher than total
            @transactions.errors[:base] << "User cannot pay more than transaction total"
            render 'show'
            return
        elsif(!@user.in? @transactions.group.users)
            @transactions.errors[:base] << "User is not in this group"
            render 'show'
            return
        elsif(@user.in? @transactions.users)
            @transactions.errors[:base] << "User is already in this transaction"
            render 'show'
            return
        else
            @transactions.users << @user
            @difference = @paid.to_d - @proportion.to_d
            @amounts.find_by(transaction_id: @transactions.id).update_attributes(difference: @difference, paid: @paid)
            
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
