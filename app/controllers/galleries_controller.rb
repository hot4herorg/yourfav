class GalleriesController < ApplicationController

	before_action :set_gallery, only: [:show, :edit, :update, :destroy, :add_video_to, :remove_video_from]

	# GET /galleries
	# GET /galleries.json
	def index
		@galleries = Gallery.all
	end

	# GET /galleries/1
	# GET /galleries/1.json
	def show
		render :modal, layout: false if request.xhr?
	end

	def add_video_to
		if @video = Video.find(params[:video_id])
			# if current_user.owns_gallery?(@gallery.id)
			respond_to do |format|
				if @gallery.videos << @video
					format.html { redirect_to @gallery, notice: "Video was successfully added to #{@gallery.name}." }
					format.js { render :add_video_to }
				else
					redirect_to @gallery, notice: "Video faild to be added to #{@gallery.name}."
				end
			end
		end
	end

	def remove_video_from
		if @video = Video.find(params[:video_id])
			@gallery.videos.delete @video # if current_user.owns_gallery?(@gallery.id)
			redirect_to @gallery, notice: "Video was successfully removed from #{@gallery.name}."
		end
	end

	# GET /galleries/new
	def new
		@gallery = Gallery.new
		12.times do
			@gallery.gallery_videos.build
		end
	end

	# GET /galleries/1/edit
	def edit
		@gallery.gallery_videos.build
	end

	# POST /galleries
	# POST /galleries.json
	def create
		@gallery = Gallery.new(gallery_params)

		respond_to do |format|
			if @gallery.save
				format.html { redirect_to @gallery, notice: 'Gallery was successfully created.' }
				format.json { render :show, status: :created, location: @gallery }
			else
				format.html { render :new }
				format.json { render json: @gallery.errors, status: :unprocessable_entity }
			end
		end
	end

	# PATCH/PUT /galleries/1
	# PATCH/PUT /galleries/1.json
	def update
		respond_to do |format|
			if @gallery.update(gallery_params)
				format.html { redirect_to @gallery, notice: 'Gallery was successfully updated.' }
				format.json { render :show, status: :ok, location: @gallery }
			else
				format.html { render :edit }
				format.json { render json: @gallery.errors, status: :unprocessable_entity }
			end
		end
	end

	# DELETE /galleries/1
	# DELETE /galleries/1.json
	def destroy
		@gallery.destroy
		respond_to do |format|
			format.html { redirect_to galleries_url, notice: 'Gallery was successfully destroyed.' }
			format.json { head :no_content }
		end
	end

	private
	# Use callbacks to share common setup or constraints between actions.
	def set_gallery
		@gallery = Gallery.find(params[:id])
	end

	# Never trust parameters from the scary internet, only allow the white list through.
	def gallery_params
		params.require(:gallery).permit(:name, :private, video_ids: [])
	end
end
