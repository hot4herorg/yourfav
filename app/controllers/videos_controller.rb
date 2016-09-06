class VideosController < ApplicationController

	before_action :authenticate_user!, except: [:index, :show, :new, :create, :preview]
	before_action :authenticate_admin!, only: [:destroy]

	before_action :set_video, only: [:show, :edit, :update, :destroy, :generate_thumbs]

	def index
		@videos = Video.with_gfy(params[:with_gfy]).page(params[:page])
		@page_title = 'All Videos'
	end

	def with_gfy
		@videos = Video.with_gfy(true).page(params[:page])
		@page_title = 'Videos w/ Gfys'
		render :index
	end

	def show
		render :show, layout: false if request.xhr?
	end

	def preview
		@video = PhnetworkScraper::Video.new params[:url]
	end

	def generate_thumbs
		@video.gen_thumbs
		redirect_to [:edit, @video]
	end

	def new
		@video = Video.new
		@video.video_stars.build
	end

	def edit
		@video.video_stars.build
	end

	# POST /videos
	# POST /videos.json
	def create
		@video = Video.new(video_params)
		# @video = Video.new PhnetworkScraper::Video.new(@video.url).to_params_hash if @video.add_by_url

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
				format.js { render :update, status: :ok, location: @video }
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

	private
	# Use callbacks to share common setup or constraints between actions.
	def set_video
		@video = Video.find(params[:id])
	end

	# Never trust parameters from the scary internet, only allow the white list through.
	def video_params
		params.require(:video).permit(:url, :add_by_url, :key, :title, :site_id, :thumb_url, :gfy, :star_tokens, video_stars_attributes: [:star_id, :_destroy])
	end
end
