Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root 'posts#index'

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }

  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#new_guest'
  end

  resources :users, only: %i[show] do
    get 'professional', on: :collection
    get 'myprofile', on: :member
    get 'selected_posts', on: :member
  end

  resources :posts do
    resources :comments
    get 'myposts', on: :collection
    post 'select_user', on: :member
    get 'application_users', on: :member
  end
  resources :bookmarks, only: %i[index create destroy]
  resources :applications, only: %i[index show create destroy]
  resources :categories
  resources :conversations, only: %i[index create] do
    resources :messages, only: %i[index create]
  end
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
end
