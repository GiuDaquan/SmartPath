Rails.application.routes.draw do

    devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

    root 'static_pages#home'

    post '/result',      to: 'static_pages#result'
    get  '/result',      to: 'static_pages#search'
    get  '/search',      to: 'static_pages#search'
    get  '/about',       to: 'static_pages#about'
    get  'users/:id',    to: 'users#show', as: :user

    resources :reviews
    resources :cars, only: [:new, :create, :edit, :update, :destroy]

end
