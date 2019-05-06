Rails.application.routes.draw do
  mount ActionCable.server => "/cable"
  mount PdfjsViewer::Rails::Engine => "/pdfjs", as: 'pdfjs'

  root 'user_time_logs#index'
  devise_for :users
  devise_scope :user do
    # match '/sign-in' => "devise/sessions#new", :as => :login
    authenticated :user do
      root 'user_time_logs#index', as: :authenticated_root
    end

    unauthenticated do
      root 'devise/sessions#new', as: :unauthenticated_root
    end
  end
  post 'vendors/import_csv'
  post 'customers/import_csv'
  post 'admin/hotels/import_csv'
  post 'admin/products/import_csv'
  post 'admin/categories/import_csv'
  post 'admin/inventories/import_csv'
  post 'admin/user_time_logs/import_csv'

  resources :user_time_logs do
    get :autocomplete_default_work_description, :on => :collection
  end

  resources :dashboards, only: [:index, :show]

  get 'get_start_second', :to => 'user_time_logs#get_start_second', as: 'get_start_second'
  get 'load_notifications', :to => 'notifications#load_notifications', as: 'load_notifications'
  get 'timelog_report', :to => 'user_time_logs#timelog_report', as: 'timelog_report'

  resources :channels do
    resources :channel_users
    resources :messages
  end

  resources :notifications, only: [:index]
  resources :users, only: [:edit, :update]
  resources :document_uploads, only: [:index, :show]
  resources :search_results, only: :index
  resources :dynamic_messages, only: :show
  resources :dynamic_item_messages, only: :show
  resources :filter_notifications, only: :show
  # resources :orders do
  #   collection do
  #     post  'update_assign_user'
  #     post  'update_order'
  #     get   'send_orders'
  #     post  'send_orders_to_vendors'
  #     get   'item_details'
  #   end
  # end

  resources :orders
    get 'supplier_info/:supplier_id', :to => 'orders#supplier_info', as: 'supplier_info'
    get 'supplier_choose', :to => 'orders#supplier_choose', as: 'supplier_choose'
    get 'receive_product/:order_product_id', :to => 'orders#receive_product', as: 'receive_product'
    get 'supplier_products/:supplier_id', :to => 'orders#supplier_products', as: 'supplier_products'

    get 'product_info/:product_id', :to => 'orders#product_info', as: 'product_info'
    get 'product_info_vc_code/:vc_code', :to => 'orders#product_info_vc_code', as: 'product_info_vc_code'
    get 'product_mfg_code/:mfg_code', :to => 'orders#product_mfg_code', as: 'product_mfg_code'
    get 'generate_pdf/:order_id', :to => 'orders#generate_pdf', as: 'generate_pdf'

  resources :inventories

  resources :products do
    collection do
      post  'change_picture'
    end
  end
  resources :inventories do
    collection do
      get   'add_item'
      get   'manage_by_hotel'
      get   'view_stocks'
      get   'show_brand'
      post  'create_item'
      post  'restock'
    end
  end

  resources :vendors do
    collection do
      get   'list'
      get   'add_item'
      get   'supplier'
      get   'products'
      get   'items'
    end
  end

  resources :order_entries do
    collection do
      post  'update_entry'
      post  'change_status'
      post  'change_status_on_checklist'
      get   'history'
      get   'attachment'
      post  'add_existing_item'
      get   'download_attachment'
      get   'list'
    end
  end

  resources :email_templates

  resources :chatroom_orders do
    resources :order_users
    resources :messages
    resources :dropfiles, only: :create
    get 'load_messages/', :to => 'chatroom_orders#load_messages', as: 'load_messages'

    resources :order_entries, only: :load_item_messages do
      get 'load_item_messages/', :to => 'chatroom_orders#load_item_messages', as: 'load_item_messages'
    end
    resources :order_entries, only: :index do
      resources :item_messages, only: [:create, :new]
    end
  end

  resources :orders do
    resources :products do
      resources :item_messages
    end
    get 'item_details/:id', :to => 'products#item_details', as: 'item_details'
    resources :messages
    get 'load_messages/:chatroom_id', :to => 'orders#load_messages', as: 'load_messages', on: :collection
    get 'cancel_msg_update/:id', :to => 'messages#cancel_msg_update', as: 'cancel_msg_update', on: :collection
  end

  resources :order_entries, only: :load_item_messages do
    get 'load_item_messages/', :to => 'orders#load_item_messages', as: 'load_item_messages'
  end


  namespace :admin do
    resources :notifications
    resources :users do
      get 'group_assign', to: 'users_groups#group_assign', as: 'group_assign'
    end
    resources :document_uploads do
      get 'new_folder_root', on: :collection
      get 'new_folder_sub'
      get 'upload_files'
      get 'doc_preview'
      get 'edit_folder'
      get 'share_file'
    end
    resources :user_time_logs
    resources :users_brands
    resources :users_groups
    resources :users_group_details
    resources :customers
    resources :inventories
    resources :vendors do
      resources :vendor_reviews
    end
    resources :default_works
    resources :products
    resources :categories
    resources :addresses
    resources :groups
    resources :style_attributes
    resources :orders do
      get 'duplicate_order', :to => 'orders#duplicate_order', as: 'duplicate_order'
      get 'archive_order', :to => 'orders#archive_order', as: 'archive_order'
    end
    resources :archive_orders, only: [:index]
    resources :order_entries
    resources :order_users
    resources :order_branches
    resources :vendors_products
    resources :vendor_categories
    resources :default_templates
    resources :brands do
      resources :hotels, only: [:show]
    end
    resources :hotels do
      get 'compose_email', :to => 'hotels#compose_email', as: 'compose_email'
    end  
    
    root to: "dashboards#index" # <--- Root route
  end
  #API Simple
  namespace :api do
    namespace :simple do
      resources :users do
        get 'list', on: :collection
        get 'branch_users', on: :collection
        get 'login', on: :collection
        get 'forgot_password', on: :collection
      end
      resources :categories do
        get 'list', on: :collection
      end
      resources :addresses do
        get 'list', on: :collection
        get 'branches', on: :collection
      end
      resources :brands do
        get 'list', on: :collection
        get 'details', to: :display
      end
      resources :groups do
        get 'list', on: :collection
      end
      resources :inventories do
        get 'list', on: :collection
        get 'overall', on: :collection
      end
      resources :products do
        get 'list', on: :collection
        get 'get_item_list', on: :collection
        get 'get_products_category', on: :collection
        post 'create_item', on: :collection
        post 'update_product', on: :collection
      end
      resources :vendors do
        get 'list', on: :collection
        get 'get_vendors_products', on: :collection
        get 'get_category_vendors', on: :collection
      end
      resources :style_attributes do
        get 'list', on: :collection
      end
      resources :orders do
        get 'list', on: :collection
        get 'send_orders', on: :collection
        get 'show_entries', on: :collection
        get 'show_users', on: :collection
        get 'get_latest_order', on: :collection
        get 'show_branches', on: :collection
        post 'update_assign_user'
      end
      resources :order_entries do
        get 'list', on: :collection
        get 'vendor_email_list',  on: :collection
        get 'attachment_list',  on: :collection
        post 'destroy_attachment', on: :collection
      end
      resources :sessions do
      end
      resources :hotels do
      end
    end
  end
  get 'static_pages/dashboard'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
