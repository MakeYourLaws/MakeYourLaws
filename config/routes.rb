MakeyourlawsOrg::Application.routes.draw do
  resources :identities

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks",
      :registrations => "users/registrations" } do
    get "login", :to => "devise/sessions#new"
    delete "logout", :to => "devise/sessions#destroy"
    get "signup", :to => "users/registrations#new"
    get "signup_from_id", :to => "users/registrations#new_from_id"
  end
    
#  match "main" => "main#index", :via => :get  # this is root
  get "introduction" => "main#introduction"
  get "principles" => "main#principles"
  get "strategy" => "main#strategy"
  get "faq" => "main#faq"
  get "help" => "main#help"
  get "contact" => "main#contact"
  
  namespace :paypal do
    resources :transactions do
      member do
        put 'refresh'
      end
    end
    resources :notifications, :only => :create
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
  
  post "versions/:id/revert" => "versions#revert", :as => "revert_version"
  
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => "main#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
