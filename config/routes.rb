Rails.application.routes.draw do

  concern :activateable do
    post 'activate'
  end

  concern :deactivateable do
    post 'deactivate'
  end

  root 'pages#home'
  get 'about'   => 'pages#about'
  get 'contact' => 'pages#contact'
  get 'become_partner' => 'pages#become_partner'

  mount Blogit::Engine => '/blog'

  get 'admin'  => 'admin/dashboard#index'
  get 'admin/' => 'admin/dashboard#index'

  devise_for :admins
  devise_for :customer, skip: [:sessions, :passwords, :registrations]
  devise_for :partners, skip: [:sessions, :passwords, :registrations]

  namespace :admin do
    resources :orders do
      resources :items
    end
    resources :customers, concerns: [:activateable, :deactivateable]
    resources :partners, concerns: [:activateable, :deactivateable]
    resources :stores, concerns: [:activateable, :deactivateable] do
      resources :inventory, only: [:index]
    end
    resources :dashboard, only: [:index]
    resources :posts
  end

  namespace :api, constraints: { format: 'json' }  do
    namespace :v1 do
      # Signup
      put 'register', to: 'registrations#create'

      # Sessions
      put 'login', to: 'sessions#create'
      put 'logout', to: 'sessions#destroy'
      delete 'logout', to: 'sessions#destroy'

      # Location
      put 'location/update', to: 'location#update'

      # Partners
      get '/partners/nearby', to: 'partners#index'


      # Messages
      get '/conversations/inbox', to: 'conversations#inbox'
      get '/conversations/sentbox', to: 'conversations#sentbox'
      get '/conversations/trash', to: 'conversations#trash'
      get '/conversations/all', to: 'conversations#all'
    end
  end
end
