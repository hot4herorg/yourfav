Rails.application.routes.draw do  

	devise_for :users
	
	resources :users, only: [:show] do
		resources :favorites, except: [:show, :edit, :update]
	end

	resources :videos do
		member do
			get 'toggle_favorite', path: 'toggle-favorite'
		end
	end

	resources :sites

	get 'static_pages/video_not_found', path: 'video-not-found'

	root 'static_pages#index'

end
