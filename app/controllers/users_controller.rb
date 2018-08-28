class UsersController < ApplicationController

	before_action :authenticate_user!
	before_action :check_privileges!, only: [:index]

	def index
		@users = User.paginate(page: params[:page])
	end

	def show
		@user = User.find(params[:id])
	end

end
