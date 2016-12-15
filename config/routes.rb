Rails.application.routes.draw do

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  resources :comics

  resources :products
  get 'product-list', to: 'products#admin_index', as: :productlist

  resources :images

  resource :cart, only: [:show, :update] do
    member do
      match :submit_address, action: :submit_address, via: [:post, :patch]
      match :checkout, action: :checkout, via: [:post, :patch]
    end
  end

  resources :order_items, only: [:create, :update, :destroy]

  resources :orders do
    member do
      match :confirm, action: :confirm, via: :get
    end
  end

  resources :destinations

  resources :payment_choices

  resources :blogs

  root 'static_pages#home'

  #get 'comics' => 'static_pages#comics'

  get 'shop' => 'products#index'

  get 'about' => 'static_pages#about'

  get 'imprint' => 'static_pages#imprint'

  get 'toc' => 'static_pages#toc'

  get 'thanks' => 'static_pages#thanks'

  # user specific
  devise_scope :user do
    get 'my-orders' => 'users/sessions#my_orders'
  end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"

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
