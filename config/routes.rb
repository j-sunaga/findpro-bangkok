Rails.application.routes.draw do
  root 'posts#index'
  devise_for :users
  resources :users, only: %i[show]
  resources :posts do
    resources :comments
    get 'myposts', on: :collection
  end
  resources :bookmarks, only: %i[index create destroy]
  resources :applications, only: %i[index show create destroy]
  resources :categories
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
