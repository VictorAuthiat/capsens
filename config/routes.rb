Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users, controllers: { registrations: 'users' }
  root to: 'pages#home'
  get 'dashboard', to: 'pages#dashboard'
  resources :contributions, only: :show
  resources :projects, only: %i[index show] do
    resources :contributions, only: %i[new create]
  end
  get 'payment', to: 'payments#payment'
  resources :contributions, only: %i[edit update]
  resources :users, only: %i[new create]
  get 'mail', to: 'posts#new'
  post '/' => 'posts#create'
  mount LetterOpenerWeb::Engine, at: '/inbox'
end
