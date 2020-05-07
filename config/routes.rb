Rails.application.routes.draw do
  root 'posts#index'
  devise_for :users
  resources :posts
  resources :bookmarks, only: [:index, :create, :destroy]
  resources :applications, only: [:index, :show, :create, :destroy]
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
