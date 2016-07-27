class WifiDog::UsersController < ApplicationController
  def login
    if params[:gw_id] and params[:gw_address] and params[:gw_port]
      session[:gw_id] = params[:gw_id]
      session[:gw_address] = params[:gw_address]
      session[:gw_port] = params[:gw_port]
    end
  end
    
  def signup
    
  end
  
end