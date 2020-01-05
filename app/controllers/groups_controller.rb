class GroupsController < ApplicationController
  def index
  end
  
  def new
  end
  
  def create
    render plain: params[:groups].inspect
  end
end
