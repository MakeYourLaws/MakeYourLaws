MakeyourlawsOrg::Application.routes.draw do
  resources :initiatives
  resources :committees
  resources :identities

  resources :carts do
    resources :cart_items, :path => 'items'
  end

  devise_for :users, :controllers => { 
    :omniauth_callbacks => "users/omniauth_callbacks",
    :registrations => "users/registrations" }

  devise_scope :user do
    get "login", :to => "devise/sessions#new"
    delete "logout", :to => "devise/sessions#destroy"
    get "signup", :to => "users/registrations#new"
    get "signup_from_id", :to => "users/registrations#new_from_id"
  end
    
#  get "main" => "main#index"  # this is root
  get "introduction" => "main#introduction"
  get "principles" => "main#principles"
  get "strategy" => "main#strategy"
  get "faq" => "main#faq"
  get "help" => "main#help"
  get "contact" => "main#contact"
  get "help/legal" => "main#help_legal"
  
  namespace :paypal do
    resources :transactions do
      member do
        patch 'refresh'
      end
    end
    resources :notifications, :only => :create  # IPN
    resources :transaction_notifications, :only => :create # PDT
     # , :only => [:show, :create, :destroy, :update] do 
      # member do
      #   get 'completed', :action => :show, :status => 'completed'
      #   get 'canceled', :action => :show, :status => 'canceled'
      #   get 'failed', :action => :show, :status => 'failed'
      # end
    # end
    # resources :preapprovals # , :only => [:show, :create, :destroy, :update] do
      # member do
      #   get 'completed'
      #   get 'canceled'
      #   get 'failed'
      # end
    # end
  end
  
  namespace :stripe do
    resources :charges
  end
  mount StripeEvent::Engine => '/stripe/callback'
  
  post "versions/:id/revert" => "versions#revert", :as => "revert_version"
  
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root "main#index"

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
