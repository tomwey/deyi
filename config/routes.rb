Rails.application.routes.draw do
  mount RedactorRails::Engine => '/redactor_rails'
  
  # 网页
  resources :pages, path: :p, only: [:show]
  
  resources :products, path: :item, only: [:show]
  
  devise_for :admins, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  
  require 'sidekiq/web'
  authenticate :admin do
    mount Sidekiq::Web => 'sidekiq'
  end
  
  mount GrapeSwaggerRails::Engine => '/apidoc'
  mount API::Dispatch => '/api'
end
