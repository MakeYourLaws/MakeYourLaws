Rails.application.routes.draw do
  resources :initiatives
  resources :committees
  resources :identities

  resources :carts do
    resources :cart_items, path: 'items'
  end
  resources :cart_items # in case there isn't a cart

  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations:      'users/registrations' }

  devise_scope :user do
    get 'login' => 'devise/sessions#new'
    delete 'logout' => 'devise/sessions#destroy'
    get 'signup' => 'users/registrations#new'
    get 'signup_from_id' => 'users/registrations#new_from_id'
  end

  #  get "main" => "main#index"  # this is root
  scope module: 'main' do
    get 'introduction'
    get 'principles'
    get 'strategy'
    get 'faq'
    get 'about/pac/bylaws', to: redirect(
      'https://docs.google.com/document/d/1BbKNamiQdlemLS28iGnkwrwar9vQ9HucK_S1PrZ2mu4/',
      status: 302)
    get 'about/pac/finances', to: redirect(
      'https://docs.google.com/spreadsheet/ccc?key=0AjmetJxi-p0VdGlJSkl5NDkxdlE4bVlLLWtYWEZtcWc',
      status: 302)
    get 'about/pac/fec_reports', to: redirect(
      'http://images.nictusa.com/cgi-bin/fecimg/?C00529743', status: 302)
    get 'about/c4/bylaws', to: redirect(
      'https://docs.google.com/document/d/1uQEetVLONuzNdY_EYvmPX5P5PHC0kgp6kE-cdeVOT0A',
      status: 302)
    get 'about/c4/finances', to: redirect(
      'https://docs.google.com/spreadsheet/ccc?key=0AjmetJxi-p0VdEg3ajFfTDJZM1VPaEZMRmd0LUJ0ZVE',
      status: 302)
    get 'about/c3/bylaws', to: redirect(
      'https://docs.google.com/document/d/1ZU8yNZVC1AnSEKHm9nLN6WlEB6K2Kn2e5J6Mb-e37AI',
      status: 302)
    get 'about/c3/finances', to: redirect(
      'https://docs.google.com/spreadsheet/ccc?key=0AjmetJxi-p0VdF8tSWwxcHJ1QTJzQWtRSzhMY1ZFSWc',
      status: 302)
    get 'fec'
    get 'help'
    get 'contact'
    get 'press'
    get 'security'
    get 'help/legal', action: 'help_legal'
    get 'tos'
    get 'privacy'
    namespace :press do
      get 'BNA-2015-03-19'
      get 'BNA-2014-05-09'
      get 'BNA-2013-11-15'
    end
    namespace :fec do
      get 'accessibility'
      get 'bitcoin'
      get 'bitcoin/caf', action: 'bitcoin_caf'
      get 'bitcoin/pacs', action: 'bitcoin_pacs'
      get 'bitcoin/aor', to: redirect(
        'https://docs.google.com/document/d/1AVuXrnNPynEcIq07MTgZPCjXMJICxtKeRH0jshYHVk8/',
        status: 302)
      get 'earmarks'
      get 'earmarks/aor', to: redirect(
        'https://docs.google.com/document/d/1YeVdRxEqC8fWnJGl9DgkcNVY6HmkCPEzyRxB_0wttU0/',
        status: 302)
      get 'laundering'
      get 'ravel_weintraub'
      get 'tplf'
      get 'volunteer_ip'
    end
  end

  namespace :amazon do
    get 'return'
    get 'abandon'
    get 'cancel'
    post 'ipn'
  end

  namespace :facebook do
    resources :payments, only: :create
  end

  namespace :paypal do
    resources :transactions do
      member do
        patch 'refresh'
      end
    end
    resources :notifications, only: :create  # IPN
    resources :transaction_notifications, only: :create # PDT
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

  namespace :admin do
    constraints IsAdmin do
      mount Resque::Server, at: 'resque'
    end
    root to: redirect('/')
    get '*any', to: redirect('/')
  end

  post 'versions/:id/revert' => 'versions#revert', :as => 'revert_version'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'main#index'

  # Last so that it has minimal URLs but doesn't override anything
  resources :profiles, except: [:show, :update, :edit, :destroy]
  resources :profiles, only: [:show, :update, :edit, :destroy], path: '/'
  # get '/:id', to: 'profiles#show' #, as: :profile

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
