Rails.application.routes.draw do

  devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register'},
                      controllers: {registrations: "users/registrations", sessions: "users/sessions", 
                                      omniauth_callbacks: "omniauth_callbacks" }
  devise_scope :user do
    get "login",   :to =>"users/sessions#new"
    delete "logout",   :to => "users/sessions#destroy"
    get "register", :to => "users/registrations#new"
    get "delete",   :to => "users/registrations#destroy"
    get "dashboard",  to: "users/registrations#edit"
    get "dashboard/password",   to: "users/registrations#password"
    put "dashboard/password",   to: "users/registrations#update_password"
    patch "dashboard/password", to: "users/registrations#update_password"
    get "dashboard/location",   to: "users/registrations#location"
  end 

  resources :events
  resources :locations
  resources :users do
    get "users/:id" => "users#show"
  end

  namespace :admin do
    get 'dashboard', to: 'dashboard#index'
    resources :users,           controller: 'users'
    resources :locations,          controller: 'locations'
    resources :events do
      get 'manager', to: 'events#manager'
    end
  end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".
  # resources :users
  get 'pages/home'
  get 'admin', to: 'admin/dashboard#index'
  get "about", to: 'pages#about'
  get "contact", to: 'pages#contact'

  # You can have the root of your site routed with "root"
  root 'events#index'

  namespace :api do
    namespace :v1 do
      devise_scope :user do
        post 'registrations' => 'registrations#create', :as => 'register'
        post 'sessions' => 'sessions#create', :as => 'login'
        delete 'sessions' => 'sessions#destroy', :as => 'logout'
      end
    end
  end

end
