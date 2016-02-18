class FavoritesController < ApplicationController

	before_action :authenticate_user!, except: []

	before_action :set_video, except: []
	# before_action :set_favorite, only: [:show, :edit, :update, :destroy]

	def index
		# @favorites = current_user.favorite_videos
	end

	# POST /favorites
	def create
		current_user.favorite_videos << @video
	end

	# DELETE /favorites/1
	def destroy
		current_user.favorite_videos.delete @video
	end

	private

	def set_video
		@video = Video.find(params[:video_id])
	end

	# def set_favorite
	# 	@favorite = Favorite.find(params[:id])
	# end

	# def favorite_params
	# 	params[:favorite]
	# end

end
