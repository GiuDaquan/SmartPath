class ApplicationController < ActionController::Base

	protect_from_forgery with: :exception

	before_action :configure_permitted_parameters, if: :devise_controller?

	protected

		def configure_permitted_parameters
			devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
			devise_parameter_sanitizer.permit(:account_update, keys:[:name])
		end

		def check_privileges!
			if (!current_user.is_admin)
				flash[:danger] = "You are not allowed to perform this action"
				redirect_to root_path
			end
		end

end
