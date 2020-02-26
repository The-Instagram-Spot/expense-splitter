class MembershipController < ApplicationController
    def create
        @user.groups << Group.find(params[:group_id])
        @groups.users << User.find()
    end
end
