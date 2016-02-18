class Api::VideosController < ApplicationController

	before_filter :set_access_control_headers, only: [:new]
	before_action :set_api_video, except: [:index]

	# GET /api/videos
	# GET /api/videos.json
	def index
		@api_videos = Api::Video.all
	end

	# GET /api/videos/1
	# GET /api/videos/1.json
	def show
	end

	# GET /api/videos/new
	def new
		# @video = Video.find_or_create_by(site_id: @api_video.site_id, key: @api_video.key) do |video|
		# 	video.url = @api_video.url
		# 	video.title = @api_video.title
		# end
	end

	# GET /api/videos/1/edit
	def edit
	end

	# POST /api/videos
	# POST /api/videos.json
	def create
		@api_video = Api::Video.new(api_video_params)

		respond_to do |format|
			if @api_video.save
				format.html { redirect_to @api_video, notice: 'Video was successfully created.' }
				format.json { render :show, status: :created, location: @api_video }
			else
				format.html { render :new }
				format.json { render json: @api_video.errors, status: :unprocessable_entity }
			end
		end
	end

	# PATCH/PUT /api/videos/1
	# PATCH/PUT /api/videos/1.json
	def update
		respond_to do |format|
			if @api_video.update(api_video_params)
				format.html { redirect_to @api_video, notice: 'Video was successfully updated.' }
				format.json { render :show, status: :ok, location: @api_video }
			else
				format.html { render :edit }
				format.json { render json: @api_video.errors, status: :unprocessable_entity }
			end
		end
	end

	# DELETE /api/videos/1
	# DELETE /api/videos/1.json
	def destroy
		@api_video.destroy
		respond_to do |format|
			format.html { redirect_to api_videos_url, notice: 'Video was successfully destroyed.' }
			format.json { head :no_content }
		end
	end

	private
	# Use callbacks to share common setup or constraints between actions.
	def set_api_video
		@api_video = PhnetworkScraper::Video.new params[:url]
	end

	# Never trust parameters from the scary internet, only allow the white list through.
	def api_video_params
		params[:api_video]
	end

	def set_access_control_headers
		headers['Access-Control-Allow-Origin'] = '*'
	end

end
