Rails.application.routes.draw do

	# namespace :api do
	# 	resources :videos, param: :url
	# 	resources :sites, :videos
	# 	get '/vidoes/:url' => 'videos#new', as: :new_video
	# end

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
		# post '/favorite' => 'favorites#create'
		# delete '/favorite' => 'favorites#destroy', as: :favorite_delete
	end

	get '/test', to: 'videos#test'

	resources :sites do
		# get 'video/:key' => 'videos#show'
	end

end
