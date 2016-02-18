class QuickGalleryController < ApplicationController

	before_action :set_video, only: [:edit, :update, :destroy]
	before_action :video_selections, only: [:new, :edit]

	def index
		@videos = Video.all.limit(4)
	end

	def new
		@video = Video.new
		render :edit, layout: false if params[:modal].present?
	end

	def edit
		render :edit, layout: false if params[:modal].present?
	end

	def update
		@replacement = Video.find(params[:replacement])
	end

	def destroy
	end

	private

	def set_video
		@video = Video.find(params[:id])
	end

	def video_selections
		exclude_video_ids = []

		@favorites = Favorite.enabled.where(user: current_user).where.not(video_id: exclude_video_ids)
		@videos = Video.where.not(id: exclude_video_ids)
	end

end
