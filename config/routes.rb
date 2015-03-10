Rails.application.routes.draw do

  devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register'},
                      controllers: {registrations: "users/registrations", sessions: "users/sessions", 
                                      omniauth_callbacks: "omniauth_callbacks" }
  devise_scope :user do
    get "login",              to:"users/sessions#new"
    delete "logout",          to: "users/sessions#destroy"
    get "register",           to: "users/registrations#new"
    get "delete",             to: "users/registrations#destroy"
    get "profile",            to: "users/registrations#edit"
    get "profile/password",   to: "users/registrations#password"
    put "profile/password",   to: "users/registrations#update_password"
    patch "profile/password", to: "users/registrations#update_password"
    get "profile/location",   to: "users/registrations#location"
  end 

  resources :events
  resources :locations
  resources :users do
    get "users/:id" => "users#show"
  end

  namespace :dashboard do
    get '',                 to: "base#show"
    resources :users,       controller: 'users'
    resources :locations,   controller: 'locations'
    resources :events do
      get 'manager',        to: 'events#manager'
      get 'render_snippet', on: :collection
    end
  end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".
  # resources :users
  get 'pages/home'
  get 'search',   to: 'pages#search'
  get 'admin',    to: 'admin/dashboard#index'
  get "about",    to: 'pages#about'
  get "contact",  to: 'pages#contact'

  # get "/admin/events/render_snippet",  as: "render_snippet", to:"admin/events#render_snippet"

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
