Rails.application.routes.draw do

  namespace :authentication, path: '', as: '' do
    resources :users, only: [:new, :create], path: '/register', path_names: {new: '/'}
    resources :sessions, only: [:new, :create, :destroy], path: '/login', path_names: {new: '/'}
  end

  resources :favorites, only: [:index, :create, :destroy], param: :product_id
  resources :users, only: :show, path: '/user', param: :username #PARA VER PERFILES DE USUARIOS
  resources :categories, except: :show
  delete 'products/:id', to: 'products#destroy'
  patch 'products/:id', to: 'products#update'
  post '/products', to: 'products#create'
  get '/products/new', to: 'products#new', as:  :new_product
  get '/products', to: 'products#index' #Para mostrar todos los productos
  get '/products/:id', to: 'products#show', as: :product  #Para mostrar un producto en concreto
  get '/products/:id/edit', to: 'products#edit', as: :edit_product  

  resources :home, path: '/' #PARA QUE AL CORRER EL LOCALHOST SE ABRA EN LA PAG DE INICIO
  
  get '/home', to: 'home#index'
  
end
