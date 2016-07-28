Rails.application.routes.draw do
  mount RedactorRails::Engine => '/redactor_rails'
  
  # 网页文档
  resources :pages, path: :p, only: [:show]
  
  # 积分商城产品详情页
  resources :products, path: :item, only: [:show]
  
  # WIFI认证系统
  namespace :wifi_dog, path: :wifi do
    get '/login'  => 'users#login',  as: :login
    post '/sign_in' => 'users#sign_in', as: :sign_in
    post '/register' => 'users#register', as: :register
    get '/signup' => 'users#signup', as: :signup
    get '/auth'   => 'wifi#auth',    as: :auth
    get '/ping'   => 'wifi#ping',    as: :ping
    get '/portal' => 'wifi#portal',  as: :portal
  end
  
  # 后台系统登录
  devise_for :admins, ActiveAdmin::Devise.config
  
  # 后台系统路由
  ActiveAdmin.routes(self)
  
  # 队列后台管理
  require 'sidekiq/web'
  authenticate :admin do
    mount Sidekiq::Web => 'sidekiq'
  end
  
  # API 文档
  mount GrapeSwaggerRails::Engine => '/apidoc'
  
  # API 路由
  mount API::Dispatch => '/api'
end
