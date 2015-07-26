class ApplicationController < ActionController::Base
	# Prevent CSRF attacks by raising an exception.
	# For APIs, you may want to use :null_session instead.
	protect_from_forgery with: :exception

	def after_sign_in_path_for(resource)
		# request.env['omniauth.origin'] || stored_location_for(resource) || user_favoritres_path(current_user) || root_path
		request.env['omniauth.origin'] || user_favorites_path(current_user) || root_path
	end

end
