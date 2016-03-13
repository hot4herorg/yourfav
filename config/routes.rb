Rails.application.routes.draw do

	namespace :api do
		resources :videos, param: :url
		# resources :sites, :videos
		# get '/vidoes/:url' => 'videos#new', as: :new_video
	end

	resources :galleries do
		member do
			put '/add/:video_id', to: :add_video_to, as: :add_video_to
			delete '/remove/:video_id', to: :remove_video_from, as: :remove_video_from
		end
	end

	devise_for :users

	resources :videos do
		# get '/details/:id' => 'videos#get_video_details'
		# get '/add_to_gallery/:gallery_id' => 'videos#add_to_gallery', as: 'add_to_gallery'
		# get '/remove_from_gallery/:gallery_id' => 'videos#remove_from_gallery', as: 'remove_from_gallery'
		post '/favorite' => 'favorites#create'
		delete '/favorite' => 'favorites#destroy', as: :favorite_delete
	end
	get '/video_details' => 'videos#get_video_details', as: 'video_details'

	get '/test', to: 'videos#test'

	resources :sites do
		# get 'video/:key' => 'videos#show'
	end

	resources :users, only: [:show]

	root 'videos#index'

end
