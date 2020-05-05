Rails.application.routes.draw do
  devise_for :users
  root 'posts#index'
  resources :posts
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
