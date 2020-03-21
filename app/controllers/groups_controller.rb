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
  
  def update
    @groups = Group.find(params[:id])
    if(params[:users][:email] != "")
      @user = User.find_by(email: params[:users][:email])
      if(!(@groups.users.exists?(:id)))
        @groups.users << @user
      end
    end
    
    if @groups.update(group_params)
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
