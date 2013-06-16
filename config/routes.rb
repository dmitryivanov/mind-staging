BoaCrm::Application.routes.draw do
  
  devise_for :users, :controllers => {:sessions => 'users/sessions'} do
    get '/users/sign_in' => 'users/sessions#new', :as => :new_user_session
    post '/users/sign_in' => 'users/sessions#create', :as => :user_session
    get '/users/sign_out' => 'users/sessions#destroy', :as => :destroy_user_session
  end
    
  constraints(Subdomain) do
    match '/' => 'dashboards#index'
  end
  
#  authenticated :users do
#    root :to => 'home#index'
#  end

  resource :dataload_mailchimp
  resources :dataload_gas
  resources :dataload_emails
  resources :dataload_ftps
  resources :dataload_manuals

  get "customer_warranty_file/file"

  get "home/index"
  get 'dataloads', to: 'home#dataload_list'
  
  root :to => 'home#index'
  resources :home
   
  get 'signup', to: 'users#new', as: 'signup'

  resources :users
  
  #resources :status_rpts
  
  resources :dataload_logs

  resources :dashboards do
    resources :dashboard_modules do
      collection do
        get 'dimension_values'
      end
    end
  end
  resources :campaigns
  resources :customers

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
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
  match 'railsthemes/landing' => 'railsthemes#landing'
  match 'railsthemes/inner' => 'railsthemes#inner'
  match 'railsthemes/jquery_ui' => 'railsthemes#jquery_ui'
  match 'railsthemes/email' => 'railsthemes#email'
  match 'railsthemes/send_email' => 'railsthemes#send_email'
end
