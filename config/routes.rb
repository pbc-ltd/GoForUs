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
      put 'update', to: 'sessions#update'
      delete 'logout', to: 'sessions#destroy'

      # Location
      put 'location/update', to: 'location#update'

      # Partners
      get '/partners/nearby', to: 'partners#index'
      put '/partners/online', to: 'partners#online'


      # Conversations
      get '/conversations/inbox', to: 'conversations#inbox'
      put '/conversations/reply', to: 'conversations#reply'

      # Messages
      get '/conversations/:conversation_id/messages', to: 'messages#index'
      get '/conversations/:conversation_id/messages/', to: 'messages#index'
      put '/conversations/:conversation_id/messages/:id/mark_read', to: 'messages#mark_as_read'

      # Orders
      get 'orders', to: 'orders#index'
      put 'orders', to: 'orders#create'

      # Jobs
      get 'jobs', to: 'jobs#index'
      put 'jobs/:id/accept', to: 'jobs#accept'
      put 'jobs/:id/decline', to: 'jobs#decline'
    end
  end
end
