Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get 'mail', to: 'posts#new'
  post '/' => 'posts#create'
  mount LetterOpenerWeb::Engine, at: '/inbox'
end
