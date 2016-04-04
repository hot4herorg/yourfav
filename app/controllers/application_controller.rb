class ApplicationController < ActionController::Base
	# Prevent CSRF attacks by raising an exception.
	# For APIs, you may want to use :null_session instead.
	protect_from_forgery with: :exception

	# redirect to current user's profile
	def after_sign_in_path_for(resource)
		user_path(current_user)
	end

	# # redirect back to current page without oauth
	# def after_sign_in_path_for(resource)
	# 	sign_in_url = new_user_session_url
	# 	request.referer == sign_in_url ? super : stored_location_for(resource) || request.referer || root_path
	# end

	# # redirect back to current page with oauth
	# def after_sign_in_path_for(resource)
	# 	request.env['omniauth.origin'] || stored_location_for(resource) || root_path
	# end

end
