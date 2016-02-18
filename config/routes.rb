Rails.application.routes.draw do

	namespace :api do
		resources :videos, param: :url
		# resources :sites, :videos
		# get '/vidoes/:url' => 'videos#new', as: :new_video
	end

	resources :galleries

	devise_for :users

	resources :videos do
		# get '/details/:id' => 'videos#get_video_details'
		post '/favorite' => 'favorites#create'
		delete '/favorite' => 'favorites#destroy', as: :favorite_delete
	end
	get '/video_details' => 'videos#get_video_details', as: 'video_details'

	get '/test' => 'videos#test'

	resources :sites do
		# get 'video/:key' => 'videos#show'
	end

	resources :users, only: [:show]

	root 'videos#index'

end
