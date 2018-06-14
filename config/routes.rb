require 'api_constraints'

Rails.application.routes.draw do

  devise_for :users
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  # API Routes
  namespace :api, defaults: {format: 'json'} do
    namespace :regimen_app, :path => 'regimen-app' do
      scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do
        resources :config, :path => 'config'
        get '/regimens' => 'regimens#index'
        get '/locales' => 'config#get_locales'
        post '/guides/login' => 'guides#login'
        post '/guides' => 'guides#create'
        post '/guides/:id'  => "guides#update"
        get '/categories' => 'config#categories'
        resources :customers, except: [:destroy] do
          collection do
            get :customer_products
          end
        end
      end
    end
  end

  root 'welcome#index'
  get '/help' => 'welcome#help'
  get '/settings' => 'welcome#settings'
  get '/account' => 'welcome#account'

  resources :regimens, :products, :variants, :guides, :product_categories
  resources :customers, :except => [:new, :create]
end
