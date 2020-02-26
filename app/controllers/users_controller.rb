class UsersController < ApplicationController
  def index
    @users = User.all
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def create
    @groups = Group.find(params[:group_id])
    @users = @groups.memberships.create(params[:email])
    redirect_to group_path(@groups)
  end
  
end
