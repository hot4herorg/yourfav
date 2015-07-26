class VideosController < ApplicationController

	before_action :authenticate_user!, only: [:toggle_favorite]

	before_action :set_video, only: [:show, :toggle_favorite, :edit, :update, :destroy]

	def index
		@videos = Video.all
	end

	def show
		render :show_modal, layout: false if params[:modal].present?
	end

	def toggle_favorite
		@video.toggle_favorite(current_user)
	end

	def new
		@video = Video.new
	end

	def edit
	end

	def create
		@video = Video.new(video_params)

		respond_to do |format|
			if @video.save
				format.html { redirect_to @video, notice: 'Video was successfully created.' }
				format.json { render :show, status: :created, location: @video }
			else
				format.html { render :new }
				format.json { render json: @video.errors, status: :unprocessable_entity }
			end
		end
	end

	def update
		respond_to do |format|
			if @video.update(video_params)
				format.html { redirect_to @video, notice: 'Video was successfully updated.' }
				format.json { render :show, status: :ok, location: @video }
			else
				format.html { render :edit }
				format.json { render json: @video.errors, status: :unprocessable_entity }
			end
		end
	end

	def destroy
		@video.destroy
		respond_to do |format|
			format.html { redirect_to videos_url, notice: 'Video was successfully destroyed.' }
			format.json { head :no_content }
		end
	end

	private

	def set_video
		@video = Video.find(params[:id])
	end

	def video_params
		params.require(:video).permit(:title, :key, :site_id)
	end

end
