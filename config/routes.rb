Rails.application.routes.draw do
  root 'pages#home'

  devise_for :users,
             path: '',
             path_names: {sign_in: 'login', sign_out: 'logout', edit: 'profile', sign_up: 'registration'},
             controllers: {omniauth_callbacks: 'omniauth_callbacks', registrations: 'registrations'}

  resources :users, only: [:show]
  resources :rooms, except: [:edit] do
    member do
      get 'listing'
      get 'pricing'
      get 'description'
      get 'photo_upload'
      get 'amenities'
      get 'location'
      get 'preload'
      get 'preview'
    end
    resources :photos, only: [:create, :destroy]
    resources :rentals, only: [:create]
  end

  resources :tenant_reviews, only: [:create, :destroy]
  resources :landowner_reviews, only: [:create, :destroy]

  get '/your_landowners' =>'rentals#your_landowners'
  get '/your_rentals' =>'rentals#your_rentals'

  get 'search' => 'pages#search'
end
