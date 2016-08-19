Rails.application.routes.draw do
  mount RedactorRails::Engine => '/redactor_rails'
  
  # 微信公众号开发
  namespace :wechat, defaults: { format: 'xml' } do
    get  '/portal' => 'home#portal'
    post '/portal' => 'home#welcome'
  end
  
  # 网页文档
  resources :pages, path: :p, only: [:show]
  
  # 积分商城产品详情页
  resources :products, path: :item, only: [:show]
  
  # 版本更新
  get '/version/info' => 'app_versions#info', as: :info_version
  
  # 关注任务相关
  resources :follow_tasks, path: :ft, only: [:show]
  get '/callback/ft' => 'follow_tasks#callback'
  
  # 分享任务相关
  # resources :share_tasks, path: :st, only: [:show]
  get '/callback/st' => 'share_tasks#callback'
  
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
  
  # 三方渠道回调
  namespace :callback do
    get '/youmi'   => 'app_callback#youmi'
    get '/qumi'    => 'app_callback#qumi'
    get '/dianjoy' => 'app_callback#dianjoy'
    get '/dianru'  => 'app_callback#dianru'
    get '/waps'    => 'app_callback#waps'
  end
  
  # 收徒功能
  namespace :shoutu do
    get '/'       => 'invite#index'
    get '/info'   => 'invite#info'
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
