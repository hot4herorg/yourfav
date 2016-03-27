Rails.application.routes.draw do

	root 'videos#index'

	devise_for :users, path: :user

	resources :users, only: [:show] do
		resources :galleries do
			resources :videos, controller: :gallery_videos, except: [:index, :new]
		end
		# resources :favorites
	end

	get '/video_details' => 'videos#get_video_details', as: 'video_details'
	resources :videos do
		resources :stars, controller: :video_stars
		# resources :thumbnails
		# post '/favorite' => 'favorites#create'
		# delete '/favorite' => 'favorites#destroy', as: :favorite_delete
	end

	resources :thumbnails

	get '/test', to: 'videos#test'

	resources :sites do
		# get 'video/:key' => 'videos#show'
	end

	resources :stars

end
