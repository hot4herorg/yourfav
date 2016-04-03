Rails.application.routes.draw do

	devise_for :users, path: :user

	# authenticated :user do
	# 	root 'videos#index', as: :authenticated_root
	# end

	root 'static_pages#home'

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

	resources :videos, concerns: [:favoritable] do
		get :preview, on: :collection
		get :generate_thumbs, path: 'generate-thumbs', on: :member
		resources :stars, controller: :video_stars
		resources :gallery_videos, as: :gallery, path: :gallery, only: [:new]
		# resources :thumbnails
	end

	resources :sites

	resources :stars, concerns: [:favoritable]

	resources :thumbnails

	get '/extension' => 'static_pages#browser_extension'
	get '/donate' => 'static_pages#donate'
	get '/test', to: 'static_pages#test'

end
