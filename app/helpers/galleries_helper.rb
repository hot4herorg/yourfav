module GalleriesHelper

	def gallery_btn
		if user_signed_in?
			current_user.galleries.first
		else
			Gallery.all.sample(1)
		end
	end

end
