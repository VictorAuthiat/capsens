Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users, controllers: { registrations: 'users' }
  root to: 'pages#home'
  get 'dashboard', to: 'pages#dashboard'
  resources :projects, only: %i[index show]
  resources :users, only: %i[new create]
  get 'mail', to: 'posts#new'
  post '/' => 'posts#create'
  mount LetterOpenerWeb::Engine, at: '/inbox'
end
