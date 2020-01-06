class PeopleController < ApplicationController
    def create
        @groups = Group.find(params[:group_id])
        @person = @groups.people.create(person_params)
        redirect_to group_path(@groups)
    end
    
    private
        def person_params
            params.require(:group).permit(:name, :email)
        end
end
