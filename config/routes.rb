ConnectMed::Application.routes.draw do

  # You can have the root of your site routed with "root"
  root to: 'landings#index'
  get '/how-it-works', to: "landings#how_it_works", as: "how_it_works"
  get '/about-us', to: "landings#about_us", as: "about_us"
  get '/doctor', to: "landings#doctor_index", as: "doctor_index"
  get '/demo', to: "landings#demo_index", as: "demo_index"
  get '/overview', to: "landings#overview", as: "overview"

# Scopes Routes & Controllers to Patient
  namespace :patient do
    resources :patients do
      member do
        get :confirm_email
      end
    end
    get 'signin', to: "sessions#new", as: 'signin'
    get 'signout', to: 'sessions#destroy', as: 'signout' #get rather than delete bc of issue with twitter bootstrap link_to
    get 'signup', to: "patients#new", as: "signup"
    post 'patients', to: "patients#create"
    get 'my_account', to: "patients#edit", as: "edit"
    patch 'my_account', to: "patients#update"
    get 'dashboard', to: "patients#dashboard", as: "dashboard"
    get 'privacy_policy', to: "patients#privacy_policy", as: "privacy_policy"
    resources :slots do
      collection do
        get 'schedule', to:"slots#schedule", as:"schedule"
        get 'index_open', to:"slots#index_open"
        get 'index_open', to:"slots#index_taken"
      end
    end
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

end
