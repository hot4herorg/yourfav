module DeviseAuth
	extend ActiveSupport::Concern

	included do
		# Include default devise modules. Others available are:
		# :confirmable, :lockable, :timeoutable and :omniauthable
		devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable
		# , :omniauthable, omniauth_providers: [:facebook, :google_oauth2]
	end

	module ClassMethods
		def from_omniauth(auth)
			where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
				user.email = auth.info.email
				user.password = Devise.friendly_token[0,20]
				user.provider = auth.provider
				user.uid = auth.uid
				# if auth.uid == '104330394152926869517'
				# 	user.admin = true
				# 	user.add_role :admin
				# 	user.add_role :gapGrants
				# end
				# user.token = auth.credentials.token
				# user.name = auth.info.nickname
			end
		end

		def from_omniauth_email_taken(auth)
			# provider and uid added to curent user
			self.uid = auth.uid
			self.provider = auth.provider
			self.save!
		end

		def new_with_session(params, session)
			super.tap do |user|
				if data = session["devise.google_data"] && session["devise.google_data"]["extra"]["raw_info"]
					user.email = data["email"] if user.email.blank?
				end
			end
		end
	end

	# def new_with_session(params, session)
	# 	if session['devise.user_attributes']
	# 		new(session['devise.user_attributes'], without_protection: true) do |user|
	# 			user.attributes = params
	# 			user.valid?
	# 		end
	# 	else
	# 		super
	# 	end
	# end

	# def password_required?
	# 	super && provider.blank?
	# end

	# def update_with_password(params, *options)
	# 	if encrypted_password.blank?
	# 		update_attributes(params, *options)
	# 	else
	# 		super
	# 	end
	# end

end