class ThumbnailsController < ApplicationController
	before_action :set_thumbnail, only: [:show, :edit, :update, :destroy]

	# GET /thumbnails
	# GET /thumbnails.json
	def index
		@thumbnails = Thumbnail.all
	end

	# GET /thumbnails/1
	# GET /thumbnails/1.json
	def show
	end

	# GET /thumbnails/new
	def new
		@thumbnail = Thumbnail.new
	end

	# GET /thumbnails/1/edit
	def edit
	end

	# POST /thumbnails
	# POST /thumbnails.json
	def create
		@thumbnail = Thumbnail.new(thumbnail_params)

		respond_to do |format|
			if @thumbnail.save
				format.html { redirect_to [:edit, @thumbnail.video], notice: 'Thumbnail was successfully created.' }
				format.json { render :show, status: :created, location: @thumbnail }
			else
				format.html { render :new }
				format.json { render json: @thumbnail.errors, status: :unprocessable_entity }
			end
		end
	end

	# PATCH/PUT /thumbnails/1
	# PATCH/PUT /thumbnails/1.json
	def update
		respond_to do |format|
			if @thumbnail.update(thumbnail_params)
				format.html { redirect_to [:edit, @thumbnail.video], notice: 'Thumbnail was successfully updated.' }
				format.json { render :show, status: :ok, location: @thumbnail }
			else
				format.html { render :edit }
				format.json { render json: @thumbnail.errors, status: :unprocessable_entity }
			end
		end
	end

	# DELETE /thumbnails/1
	# DELETE /thumbnails/1.json
	def destroy
		video = @thumbnail.video
		@thumbnail.destroy
		respond_to do |format|
			format.html { redirect_to [:edit, video], notice: 'Thumbnail was successfully destroyed.' }
			format.json { head :no_content }
		end
	end

	private
	# Use callbacks to share common setup or constraints between actions.
	def set_thumbnail
		@thumbnail = Thumbnail.find(params[:id])
	end

	# Never trust parameters from the scary internet, only allow the white list through.
	def thumbnail_params
		params.require(:thumbnail).permit()
	end
end
