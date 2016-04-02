Rails.application.routes.draw do

	root 'videos#index'

	get '/extension' => 'static_pages#browser_extension'

	devise_for :users, path: :user

	concern :favoritable do
		member do
			post '/favorite' => 'favorites#create'
			delete '/unfavorite' => 'favorites#destroy'
		end
	end

	resources :users, only: [:show] do
		resources :galleries do
			resources :videos, controller: :gallery_videos, except: [:index, :new]
		end
	end

	get '/video_details' => 'videos#get_video_details', as: 'video_details'
	resources :videos, concerns: [:favoritable] do
		member do
			get '/generate-thumbs' => 'videos#gen_thumbs'
		end
		resources :stars, controller: :video_stars
		resources :gallery_videos, as: :gallery, path: :gallery, only: [:new]
		# resources :thumbnails
	end

	resources :thumbnails

	get '/test', to: 'videos#test'

	resources :sites do
		# get 'video/:key' => 'videos#show'
	end

	resources :stars, concerns: [:favoritable]

end
