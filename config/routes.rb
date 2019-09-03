Rails.application.routes.draw do
  root to: 'posts#new'
  post '/' => 'posts#create'
  mount LetterOpenerWeb::Engine, at: "/inbox"
end
