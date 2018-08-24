Rails.application.routes.draw do

    devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
    devise_scope :user do
        get  'users/sign_out',  to: 'devise/sessions#destroy'
    end

    root 'static_pages#home'

    post '/result',         to: 'static_pages#result'
    get  '/result',         to: 'static_pages#search'
    get  '/search',         to: 'static_pages#search'
    get  '/about',          to: 'static_pages#about'
    get  '/users',          to: 'users#index'
    get  'users/:id',       to: 'users#show', as: :user
    get  '/administration', to: 'administration#home'
    get  'promotions/:id',  to: 'administration#promote', as: :promotion
    get  'demotions/:id',   to: 'administration#demote', as: :demotion
    get  'insertions',      to: 'administration#new_user'
    post 'insertions',      to: 'administration#create_user', as: :insertion
    get  'bans/:id',        to: 'administration#ban_user', as: :ban

    resources :reviews
    resources :cars, only: [:new, :create, :edit, :update, :destroy]

end
