class FavoritesController < ApplicationController

	before_action :authenticate_user!

	before_action :set_user
	before_action :set_favorite, only: [:destroy]

	def index
		# @favorites = Favorite.all
		@favorites = current_user.favorites.enabled
	end

	def new
		@favorite = Favorite.new
	end

	def create
		@favorite = Favorite.new(favorite_params)
		@favorite.user = current_user

		respond_to do |format|
			if @favorite.save_video_from_url
				format.html { redirect_to user_favorites_path(@user), notice: 'Favorite was successfully created.' }
				format.json { render :show, status: :created, location: @favorite }
			else
				format.html { render :new }
				format.json { render json: @favorite.errors, status: :unprocessable_entity }
			end
		end
	end

	def destroy
		@favorite.destroy
		respond_to do |format|
			format.html { redirect_to user_favorites_path(@user), notice: 'Favorite was successfully destroyed.' }
			format.json { head :no_content }
		end
	end

	private

	def set_user
		@user = User.find(params[:user_id])
	end

	def set_favorite
		@favorite = Favorite.find(params[:id])
	end

	def favorite_params
		params.require(:favorite).permit(:scrapee_url)
	end

end
