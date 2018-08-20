class AdministrationController < ApplicationController

	before_action :authenticate_user!
	before_action :check_privileges!

	def home
	end

	def promote
		if (current_user.id != params[:id])
			User.find(params[:id]).update_attribute(:is_admin, true)
			flash[:success] = "Successfully promoted user"
			redirect_to users_path
		end
	end

	def demote
		if (current_user.id != params[:id])
			User.find(params[:id]).update_attribute(:is_admin, false)
			flash[:success] = "Successfully demoted user"
			redirect_to users_path
		end
	end

	def new_user
		@user = User.new
	end

	def create_user
		@user = User.new(user_params)
		debugger
		if (@user.save)
			flash[:success] = "User succesfully created"
			redirect_to users_path
		else
			render "new_user.html.erb"
		end
	end

	def ban_user
		User.find(params[:id]).destroy
		flash[:success] = "User succesfully banned"
		redirect_to users_path
	end



	private

		def user_params
			params.require(:user).permit(:name, :email, :password, :password_confirmation, :is_admin)
		end

end
