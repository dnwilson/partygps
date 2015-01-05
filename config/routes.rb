Rails.application.routes.draw do
  resources :places

  resources :events

  get 'pages/home'

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

  resources :users do
    get "users/:id" => "users#show"
  end

  get 'admin', to: 'admin/dashboard#index'

  namespace :admin do
    get 'dashboard', to: 'dashboard#index'
    resources :users,           controller: 'users'
    resources :locations,       controller: 'locations'
    resources :events do
      get 'manager', to: 'events#manager'
    end
    # resources :ticket_types do
    #   put "add",   to: "ticket_types#add"
    #   patch "add", to: "ticket_types#add"
    # end
  end

  mount RailsAdmin::Engine => '/dashboard', as: 'rails_admin'
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".
  # resources :users

  get "about", to: 'pages#about'
  get "contact", to: 'pages#contact'

  # You can have the root of your site routed with "root"
  root 'pages#home'

  namespace :api do
    namespace :v1 do
      devise_scope :user do
        post 'registrations' => 'registrations#create', :as => 'register'
        post 'sessions' => 'sessions#create', :as => 'login'
        delete 'sessions' => 'sessions#destroy', :as => 'logout'
      end
    end
  end

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
