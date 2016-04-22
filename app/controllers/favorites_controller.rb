class FavoritesController < ApplicationController

	before_action :authenticate_user!, except: []
	
	before_action :set_object, except: [:index]

	def create
		@object.liked_by current_user
	end

	def destroy
		@object.unliked_by current_user
	end

	private

	def set_object
		klass = request.path.split('/')[1].classify.constantize
		@object = klass.find(params[:id])
	end

end
