class GroupsController < ApplicationController
  def index
    @groups = Group.all
  end
  
  def show
    @groups = Group.find(params[:id])
  end
  
  def new
  end
  
  def create
    @groups = Group.new(group_params)
    
    @groups.save
    redirect_to @groups
    
  end

  
  private
    def group_params
      params.require(:groups).permit(:group_name, :group_description)
    end
    
end
