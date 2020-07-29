Rails.application.routes.draw do
  get 'home/top'
  get 'home/about'
  root to: 'home#top'
  devise_for :users, controllers: {
  	sessions: 'users/sessions',
  	registrations: 'users/registrations'
	}
  resources :users, only: [:show]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
