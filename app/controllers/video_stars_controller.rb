class VideoStarsController < ApplicationController

	# before_action :authenticate_user!, except: [:index, :show]

	before_action :set_video, except: [:autocomplete]
	before_action :set_video_star, only: [:destroy]

	def autocomplete
		@stars = Star.all
	end

	# GET /video_stars/new
	def new
		@video_star = VideoStar.new video: @video
	end

	# POST /video_stars
	# POST /video_stars.json
	def create
		@star = Star.find_or_create_by(name: params[:video_star][:star_name])
		@video_star = VideoStar.new(video: @video, star: @star)

		respond_to do |format|
			if @video_star.save
				format.html { redirect_to @video, notice: 'Video star was successfully created.' }
				format.json { render :show, status: :created, location: @video_star }
			else
				format.html { render :new }
				format.json { render json: @video_star.errors, status: :unprocessable_entity }
			end
		end
	end

	# DELETE /video_stars/1
	# DELETE /video_stars/1.json
	def destroy
		@video_star.destroy
		respond_to do |format|
			format.html { redirect_to @video, notice: 'Video star was successfully destroyed.' }
			format.json { head :no_content }
		end
	end

	private
	def set_video
		@video = Video.find(params[:video_id])
	end

	def set_video_star
		@video_star = VideoStar.find(params[:id])
	end

	def video_star_params
		# params.fetch(:video_star, {})
		params.require(:video_star).permit(:star_name)
	end
end
