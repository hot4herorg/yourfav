class VideosController < ApplicationController

	before_action :set_video, only: [:show, :edit, :update, :destroy]

	# GET /videos
	# GET /videos.json
	def index
		@videos = Video.page(params[:page])
	end

	# GET /videos/1
	# GET /videos/1.json
	def show
		render :modal, layout: false if request.xhr?
	end

	def test
		url = 'http://www.xvideos.com/video2541006/jessica_jaymes_-_milf_memoirs'
		@video = PhnetworkScraper::Video.new url
		render text: @video.to_json
		# render text: @video.thumb_url
	end

	# GET /videos/new
	def new
		# @video = params[:url].present? ? Video.new( PhnetworkScraper::Video.new(params[:url]) ) : Video.new
		@video = Video.new
	end

	# GET /videos/1/edit
	def edit
	end

	# POST /videos
	# POST /videos.json
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

	# PATCH/PUT /videos/1
	# PATCH/PUT /videos/1.json
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

	# DELETE /videos/1
	# DELETE /videos/1.json
	def destroy
		@video.destroy
		respond_to do |format|
			format.html { redirect_to videos_url, notice: 'Video was successfully destroyed.' }
			format.json { head :no_content }
		end
	end

	# GET /videos/:id/details
	def get_video_details
		@video = PhnetworkScraper::Video.new params[:url]
	end

	private
	# Use callbacks to share common setup or constraints between actions.
	def set_video
		@video = Video.find(params[:id])
	end

	# Never trust parameters from the scary internet, only allow the white list through.
	def video_params
		params.require(:video).permit(:url, :key, :title, :site_id, :thumb_url)
	end
end
