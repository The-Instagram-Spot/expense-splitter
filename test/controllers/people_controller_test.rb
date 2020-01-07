class PeopleController < ApplicationController
    def create
        @groups = Group.find(params[:group_id])
        @person = @groups.people.create(person_params)
        redirect_to group_path(@groups)
    end
    
    def destroy
        @groups = Group.find(params[:group_id])
        @person = @groups.people.find(params[:id])
        @person.destroy
        redirect_to group_path(@groups)
    end
    
    private
        def person_params
            params.require(:person).permit(:name, :email)
        end
end