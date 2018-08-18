Rails.application.routes.draw do

    devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

    root 'static_pages#home'

    get 'static_pages/home'
    get 'static_pages/about'
    get 'static_pages/search'
    get 'static_pages/result'
    # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
