Rails.application.routes.draw do
  get 'users/new'
  get 'users/create'
  get 'users/update'
  get 'users/edit'
  get 'users/destroy'
  get 'users/index'
  get 'users/show'
  resources :events
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: "users/registrations",
    confirmations: "users/confirmations",
  }

  post 'password_reset/', to: 'password_resets#create'
  patch 'password_reset/', to: 'password_resets#update'

  resources :users do
    member do
      post 'add_role'
      post 'remove_role'
      get 'get_user_roles'
    end
    collection do
      get 'get_all_roles'
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
