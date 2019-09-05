Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users' } do
    get ':user/edit-profile' => 'devise/registration#edit', :as => :edit_user_profile
  end
  root to: 'pages#home'
  get 'dashboard', to: 'pages#dashboard'

  resources :users, only: [:new, :create]
  get 'mail', to: 'posts#new'
  post '/' => 'posts#create'
  mount LetterOpenerWeb::Engine, at: '/inbox'
end
