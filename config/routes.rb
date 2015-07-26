Rails.application.routes.draw do  

	devise_for :users
	
	resources :users, only: [:show] do
		resources :favorites, except: [:show, :edit, :update]
	end

	resources :videos

	resources :sites

	get 'static_pages/video_not_found', path: 'video-not-found'

	root 'static_pages#index'

end
