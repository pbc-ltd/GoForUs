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
end
