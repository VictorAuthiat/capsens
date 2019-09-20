Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users, controllers: { registrations: 'users' }
  root to: 'pages#home'
  get 'dashboard', to: 'pages#dashboard'
  resources :projects, only: %i[index show] do
    resources :contributions, only: %i[new create]
    collection do
      match 'search' => 'projects#search', via: %i[get post], as: :search
    end
  end
  get 'billing', to: 'bills#billing', via: %i[get post]
  get 'hook', to: 'bills#hook'

  get 'payment', to: 'payments#payment'
  get 'bankwire', to: 'projects#bankwire'

  resources :contributions, only: %i[show edit update]
  resources :users, only: %i[new create]

  get 'mail', to: 'posts#new'
  post '/' => 'posts#create'
  mount LetterOpenerWeb::Engine, at: '/inbox'
end
