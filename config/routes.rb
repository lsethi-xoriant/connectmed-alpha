ConnectMed::Application.routes.draw do

  # You can have the root of your site routed with "root"
  root to: 'welcome#index'

# Scopes Routes & Controllers to Patient
  namespace :patient do
    get 'signin', to: "sessions#new", as: 'signin'
    get 'signout', to: 'sessions#destroy', as: 'signout' #get rather than delete bc of issue with twitter bootstrap link_to
    get 'signup', to: "patients#new", as: "signup"
    post 'patients', to: "patients#create"
    get 'my_account', to: "patients#edit", as: "edit"
    patch 'my_account', to: "patients#update"
    get 'dashboard', to: "patients#dashboard", as: "dashboard"
    get 'privacy_policy', to: "patients#privacy_policy", as: "privacy_policy"
    resources :sessions, only: [:new, :create, :destroy]
    resources :pharmacies
    resources :consults do
      resources :pharmacies
      resources :prescriptions do
        member do
          get '/download' => 'prescriptions#download', :as => :download
        end
      end
      member do
        get 'left'
        get 'enter'
        get 'finish'
      end
    end
  end


  get '/doctors/dashboard', to: 'doctors#dashboard', as: 'doctors_dashboard'
  get '/doctor', to: "welcome#doctor_index"
  namespace :doctor do
    get 'signin', to: "sessions#new", as: 'signin'
    get 'signout', to: 'sessions#destroy', as: 'signout' #get rather than delete bc of issue with twitter bootstrap link_to
    get 'signup', to: "doctors#new", as: "signup"
    post 'doctors', to: "doctors#create"
    get 'my_account', to: "doctors#edit", as: "edit"
    patch 'my_account', to: "doctors#update"
    get 'dashboard', to: "doctors#dashboard", as: "dashboard"
    get 'privacy_policy', to: "doctors#privacy_policy", as: "privacy_policy"
    resources :sessions, only: [:new, :create, :destroy]
    resources :consults do
      resources :prescriptions do
        member do
          get '/download' => 'prescriptions#download', :as => :download
        end
      end
      member do
        get 'finish'
      end
    end
  end


  #For Contact Form
  resources "contacts", only: [:new, :create]

  # All routes
  get "dashboards/dashboard_1"
  get "dashboards/dashboard_2"
  get "dashboards/dashboard_3"
  get "dashboards/dashboard_4_1"

  get "layoutsoptions/index"
  get "layoutsoptions/off_canvas"

  get "graphs/flot"
  get "graphs/morris"
  get "graphs/rickshaw"
  get "graphs/chartjs"
  get "graphs/chartist"
  get "graphs/peity"
  get "graphs/sparkline"

  get "mailbox/inbox"
  get "mailbox/email_view"
  get "mailbox/compose_email"
  get "mailbox/email_templates"
  get "mailbox/basic_action_email"
  get "mailbox/alert_email"
  get "mailbox/billing_email"

  get "metrics/index"

  get "widgets/index"

  get "forms/basic_forms"
  get "forms/advanced"
  get "forms/wizard"
  get "forms/file_upload"
  get "forms/text_editor"

  get "appviews/contacts"
  get "appviews/profile"
  get "appviews/projects"
  get "appviews/project_detail"
  get "appviews/file_menager"
  get "appviews/calendar"
  get "appviews/faq"
  get "appviews/timeline"
  get "appviews/pin_board"
  get "appviews/teams_board"
  get "appviews/social_feed"
  get "appviews/clients"
  get "appviews/outlook_view"
  get "appviews/blog"
  get "appviews/article"
  get "appviews/issue_tracker"

  get "pages/search_results"
  get "pages/lockscreen"
  get "pages/invoice"
  get "pages/invoice_print"
  get "pages/login"
  get "pages/login_2"
  get "pages/forgot_password"
  get "pages/register"
  get "pages/not_found_error"
  get "pages/internal_server_error"
  get "pages/empty_page"

  get "miscellaneous/notification"
  get "miscellaneous/nestablelist"
  get "miscellaneous/timeline_second_version"
  get "miscellaneous/forum_view"
  get "miscellaneous/forum_post_view"
  get "miscellaneous/google_maps"
  get "miscellaneous/code_editor"
  get "miscellaneous/modal_window"
  get "miscellaneous/validation"
  get "miscellaneous/tree_view"
  get "miscellaneous/chat_view"
  get "miscellaneous/agile_board"
  get "miscellaneous/diff"
  get "miscellaneous/sweet_alert"
  get "miscellaneous/idle_timer"
  get "miscellaneous/spinners"
  get "miscellaneous/live_favicon"

  get "uielements/typography"
  get "uielements/icons"
  get "uielements/draggable_panels"
  get "uielements/buttons"
  get "uielements/video"
  get "uielements/tables_panels"
  get "uielements/tabs"
  get "uielements/notifications_tooltips"
  get "uielements/badges_labels_progress"

  get "gridoptions/index"

  get "tables/static_tables"
  get "tables/data_tables"
  get "tables/foo_tables"
  get "tables/jqgrid"

  get "commerce/products_grid"
  get "commerce/products_list"
  get "commerce/product_edit"
  get "commerce/orders"

  get "gallery/basic_gallery"
  get "gallery/bootstrap_carusela"

  get "cssanimations/index"

  get "landing/index"

end
