Rails.application.routes.draw do


  resources :hellos
  resources :hellos
  resources :hais
  devise_for :users
  resources :ratings
  resources :tags
  resources :comments
  resources :topics
  resources :posts
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  #get "posts/super_method"
  #match "supre" => "posts#supre_method", :via => :get

  get 'comments/:id/rate' => 'comments#rate', as: :'comment_rate'

  patch 'comments/:id/add_rate' => 'comments#add_rate', as: :'add_comment_rate'

  patch 'posts/:id/add_rating' => 'posts#add_rating', as: :'add_post_rate'

  root 'topics#index'

  match '/device' => 'topics#device', :via => :get

  match "user" => "posts#user", :via=> :get

  #match "/posts" => "posts#index", :via=> :get

  post 'posts/update_status'

	resources :topics do
		resources :posts 
	end
  
	resources :posts do
		resources :comments
	end


   
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
