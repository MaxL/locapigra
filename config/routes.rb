Rails.application.routes.draw do

  resources :commissions
  resources :commission_images do
    collection do
      patch :sort
    end
  end

  resources :subscribers do
    member do
      match :subscribe, action: :subscribe, via: :patch
      match :unsubscribe, action: :unsubscribe, via: :patch
    end
  end

  get 'confirm-email' => 'subscribers#confirm_email'

  post 'send_commission_enquiry' => 'commissions#create_message'
  get 'files/download'

  match 'files/clawsoffury', to: 'files#clawsoffury', via: :post

  get 'files/clawspdf' => 'files#clawspdf'
  get 'files/clawsepub' => 'files#clawsepub'
  get 'files/clawscbr' => 'files#clawscbr'

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  resources :comics

  resources :webcomics

  resources :products
  get 'product-list', to: 'products#admin_index', as: :productlist

  resources :images

  resources :webcomic_pages do
    collection do
      patch :sort
    end
  end
  resources :webcomic_chapters
  get 'chapters', to: 'webcomic_chapters#index', as: :chapters

  resource :cart, only: [:show, :update] do
    member do
      match :submit_address, action: :submit_address, via: [:post, :patch]
      match :checkout, action: :checkout, via: [:post, :patch]
    end
  end

  resources :order_items, only: [:create, :update, :destroy, :index]

  resources :orders do
    member do
      match :confirm, action: :confirm, via: :get
    end
  end

  resources :destinations

  resources :payment_choices

  resources :blogs

  resources :paypal_notifications

  root 'static_pages#home'

  #get 'comics' => 'static_pages#comics'

  get 'shop' => 'products#index'

  get 'about' => 'static_pages#about'

  get 'imprint' => 'static_pages#imprint'

  get 'terms' => 'static_pages#toc'

  get 'data-protection' => 'static_pages#dataprotection', as: 'dataprotection'

  get 'thanks' => 'static_pages#thanks'

  # user specific
  devise_scope :user do
    get 'my-orders' => 'users/sessions#my_orders'
    get 'my_order', to: 'orders#my_order'
  end

end
