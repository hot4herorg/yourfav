class OmniauthCallbacksController < Devise::OmniauthCallbacksController

	def all
		omniauth = request.env["omniauth.auth"]
		# render text: omniauth.to_yaml
		@player = Player.from_omniauth(omniauth)
		session[:facebook_token]  = omniauth.credentials.token
		if @player.persisted?
			sign_in_and_redirect @player, event: :authentication
			set_flash_message(:notice, :success, kind: "Facebook") if is_navigational_format?
		else
			session["devise.facebook_data"] = omniauth
			redirect_to new_user_registration_url
		end
	end
	alias_method :facebook, :all

end