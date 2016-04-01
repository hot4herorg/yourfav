class GalleryVideosController < ApplicationController

	before_action :set_user, except: [:new]
	before_action :set_gallery, except: [:index, :new]
	before_action :set_gallery_video, only: [:show, :edit, :update, :destroy]
	before_action :set_video, except: [:new]

	layout false, only: [:new]

	# GET /gallery_videos
	# GET /gallery_videos.json
	def index
		@gallery_videos = @gallery.videos
	end

	# GET /gallery_videos/1
	# GET /gallery_videos/1.json
	def show
		redirect_to [@user, @gallery]
	end

	# GET /gallery_videos/new
	def new
		# @gallery_video = GalleryVideo.new gallery: @gallery, video: @video
		@video = Video.find(params[:video_id])
	end

	# GET /gallery_videos/1/edit
	def edit
	end

	# POST /gallery_videos
	# POST /gallery_videos.json
	def create
		@gallery_video = GalleryVideo.new gallery: @gallery, video: @video

		respond_to do |format|
			if @gallery_video.save
				format.html { redirect_to [@user, @gallery], notice: 'Gallery video was successfully created.' }
				format.json { render :show, status: :created, location: @gallery_video }
			else
				format.html { render :new }
				format.json { render json: @gallery_video.errors, status: :unprocessable_entity }
			end
		end
	end

	# PATCH/PUT /gallery_videos/1
	# PATCH/PUT /gallery_videos/1.json
	def update
		respond_to do |format|
			if @gallery_video.update(gallery_video_params)
				format.html { redirect_to @gallery_video, notice: 'Gallery video was successfully updated.' }
				format.json { render :show, status: :ok, location: @gallery_video }
			else
				format.html { render :edit }
				format.json { render json: @gallery_video.errors, status: :unprocessable_entity }
			end
		end
	end

	# DELETE /gallery_videos/1
	# DELETE /gallery_videos/1.json
	def destroy
		@gallery_video.destroy
		respond_to do |format|
			format.html { redirect_to [@user, @gallery], notice: 'Gallery video was successfully destroyed.' }
			format.json { head :no_content }
		end
	end

	private

	def set_user
		@user = User.find(params[:user_id])
	end

	def set_gallery
		@gallery = Gallery.find(params[:gallery_id])
	end

	def set_gallery_video
		@gallery_video = GalleryVideo.find_by(gallery: @gallery, video_id: params[:id])
	end

	def set_video
		@video = Video.find(params[:id])
	end

	# Never trust parameters from the scary internet, only allow the white list through.
	def gallery_video_params
		params.require(:gallery_video).permit(:gallery_id)
	end
end
