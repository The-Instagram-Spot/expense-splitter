class GroupsController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :verify_authenticity_token
  
  def index
    @groups = Group.all
    @user = current_user
  end
  
  def show
    @groups = Group.find(params[:id])
  end
  
  def new
    @groups = Group.new
  end
  
  def edit
    @groups = Group.find(params[:id])
  end
  
  def create
    @groups = Group.new(group_params)
    @groups.users << current_user
    
    if @groups.save
     redirect_to @groups
    else
      render 'new'
    end
  end
  
  def settle_up
    @group = Group.find(params[:group_id])
    @users = @group.users
    @transactions = @group.transactions
    
    @isowed = Hash.new
    @owes = Hash.new
    
    @users.each do |user| #for each user
      @total = (0.0).to_d
      if(!user.transactions.empty?) #if user has transactions
        @transactions.each do |trx| #for each transaction in the group
          if(user.transactions.exists?(trx.id)) #if the transaction is in the user's transactions
            @total = @total + (user.amounts.find_by(user_id: user.id, transaction_id: trx.id).difference) #add up user differences
          end
        end
      end
      if(@total > 0)
        @isowed[user] = @total
      elsif(@total < 0)
        @owes[user] = @total
      end
    end
    
    @isowed = (@isowed.sort_by{|user, total| -total}).to_h
    @owes = (@owes.sort_by{|user, total| total}).to_h
    
    @settle = Hash.new {|is_owed, amount| is_owed[amount] = Hash.new(0)}
    
    
    @isowed.each do |owed_user, owed_amount| #positive
      @temp = @isowed[owed_user]
      @owes.each do |owes_user, owes_amount| #negative 
        if(@temp + owes_amount == 0)
          @owes[owes_user] = 0
          @isowed[owed_user] = 0
          @isowed.delete(owed_user)
          @owes.delete(owes_user)
          @settle[owes_user][owed_user] = @temp
          break
        elsif(@temp + owes_amount > 0)  
          @owes[owes_user] = 0   
          @owes.delete(owes_user)  
          #@isowed[owed_user] = owed_amount + owes_amount
          @temp = @temp + owes_amount
          @settle[owes_user][owed_user] = -owes_amount
        
        elsif(@temp + owes_amount < 0)
          @owes[owes_user] = owes_amount + @temp
          @settle[owes_user][owed_user] = @temp
          @isowed[owed_user] = 0
          @isowed.delete(owed_user)
          break
        end
        
        
      end
      
    end
  
    render 'settle_up'
  end
  
  def add_members
    @group = Group.find(params[:group_id])
  end
  
  def update
    @groups = Group.find(params[:id])
    if(params[:users][:email] != "")
      @user = User.find_by(email: params[:users][:email])
      if(!(@groups.users.exists?(@user.id)) && !@user.nil?)
        @groups.users << @user
      end
    end
    
    if @groups.update(group_user_params)
      redirect_to @groups
    else
      render 'edit'
    end
  end
  
  def destroy 
    @groups = Group.find(params[:id])
    @groups.destroy
    
    redirect_to groups_path
  end

  
  private
    def group_params
      params.require(:group).permit(:group_name, :group_description, users_attributes:[:email])
    end
    
    def group_user_params
      params.permit(:group, :group_name, :group_description, users_attributes:[:email])
    end
    
end
