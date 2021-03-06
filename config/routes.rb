Jeeter::Application.routes.draw do
  root to: 'pages', action: :front_page
  get '/front', to: 'pages', action: :front_page

  resources :blog, only: [:index, :show] do
    resources :comments, only: [:create]
  end

  namespace :blog do
    resources :users, path: 'authors', only: [:show]
    resources :categories, only: [:show]
  end

  namespace :admin do
    get '/login', to: 'sessions#index'
    post '/login', to: 'sessions#create'
    get '/logout', to: 'sessions#destroy'
    get '/', to: 'dashboards#index'
    post '/comments/approve', to: 'comments#approve'

    resources :posts, except: [:show]
    resources :categories, except: [:show]
    resources :tags, except: [:show]
    resources :uploads, except: [:show], path: 'media'
    resources :comments, except: [:show, :new, :create]
  end
end
