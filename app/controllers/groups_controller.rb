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
      @total = 0
      if(!user.transactions.empty?) #if user has transactions
        @transactions.each do |trx| #for each transaction in the group
          if(user.transactions.exists?(trx.id)) #if the transaction is in the user's transactions
            @total = @total + (user.amounts.find_by(user_id: user.id, transaction_id: trx.id).difference) #add up user differences
          end
        end
      end
      if(@total > 0)
        #@isowed << user
        @isowed[user] = @total
      elsif(@total < 0)
        #@owes << user
        @owes[user] = @total
      end
    end
    
    @isowed.sort_by { |user, total| total }
    @owes.sort_by { |user, total| total }
  
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