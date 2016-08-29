class WifiDog::WifiController < ApplicationController
  def login
    
    if params[:gw_id].blank? or params[:gw_address].blank? or params[:gw_port].blank? or params[:mac].blank?
      render status: :forbidden
      return
    end
    
    session[:gw_id]      = params[:gw_id]
    session[:gw_address] = params[:gw_address]
    session[:gw_port]    = params[:gw_port]
    session[:mac]        = params[:mac]
    
    @ap = AccessPoint.where(gw_id: params[:gw_id].downcase).first
  end
  
  # 扫码访问或者点击连接访问
  def download_auth
    gw_id      = session[:gw_id]     
    gw_address = session[:gw_address]
    gw_port    = session[:gw_port]   
    client_mac = session[:mac]     
    
    @ap = AccessPoint.where(gw_id: gw_id).first
    if @ap.blank?
      render status: :forbidden
      return
    end
    
    # @client = WifiClient.where(mac: client_mac, access_point: @ap).first_or_create
    # 
    # # 初次上网免费30分钟
    # wifi_length = (CommonConfig.free_wifi_length || 2).to_i
    # @client.expired_at = Time.now + wifi_length.minutes
    # @client.token = SecureRandom.uuid if @client.token.blank?
    # @client.save!
    
    token = SecureRandom.uuid
    
    # 注册网关
    redirect_to('http://' + gw_address + ':' + gw_port + "/wifidog/auth?token=#{token}")
  end
  
  def auth
    
    auth = 0
    
    if CommonConfig.banned_macs.blank?
      mac_banned = false
    elsif CommonConfig.banned_macs.split(',').include?(params[:mac])
      mac_banned = true
    else
      mac_banned = false
    end
    
    @ap = AccessPoint.find_by(gw_id: params[:gw_id])
    
    # 由网关传递过来
    token = params[:token]
    
    if !wifi_status = WifiStatus.find_by(token: token)
      puts "无效的上网Token: #{token}"
    else
      user = wifi_status.user
      case params[:stage]
      when 'login' # 初次认证登录
        if user.blank?
          puts "无效的用户上网状态信息"
        elsif !user.has_enough_wifi_length? or !wifi_status.online
          puts "没有足够的网时或用户已经关闭WiFi了"
        elsif mac_banned
          puts "Banned MAC tried logging in at " + Time.now.to_s + " with MAC: " + params[:mac]
        else
          auth = 1
          # 记录上网日志
          WifiLog.create!(user_id: user.id, access_point_id: @ap.try(:id), mac: params[:mac], used_at: Time.zone.now)
          
          # wifi_status.online = true
          # wifi_status.save!
        end
      when 'counters' # 已经认证登录过
        connection = user.current_connection
        if !connection.closed?
          if !mac_banned and user.has_enough_wifi_length?
            auth = 1
            # 更新当前连接的上网状态信息
            if connection.used_at.blank?
              connection.used_at = Time.zone.now
            end
            
            connection.ip = params[:ip]
            connection.incoming_bytes = params[:incoming]
            connection.outgoing_bytes = params[:outgoing]
            
            connection.save
            
          else
            connection.close!
          end
        end
      when 'logout' # 已经退出登录
        puts "Logging out: #{params[:token]}"
        connection = user.current_connection
        connection.close!
      else
        puts "Invalid stage: #{params[:stage]}"
      end
    end
    
    # 通知网关是否连上外网
    render text: "Auth: #{auth}"
  end
  
  def ping
    @ap = AccessPoint.find_by(gw_id: params[:gw_id])
    unless @ap.blank?
      @ap.update_attributes({
        sys_uptime: params[:sys_uptime],
        sys_load: params[:sys_load],
        sys_memfree: params[:sys_memfree],
        wifidog_uptime: params[:wifidog_uptime],
        client_count: params[:client_count],
        update_time: Time.now
      })
    end
    render text: "Pong"
  end
  
  def portal
    
    auth_result = params[:auth_result]
    client_mac  = params[:mac]
    
    if auth_result == 'failed'
      puts '连接外网失败'
    else
      puts '连接外网成功'
    end
    
    render status: :ok
    return
    
    # 重定向到一个固定的欢迎页面，有可能是下载app的广告页面
    # redirect_to 'http://'
    # client_mac  = params[:mac]
    # auth_result = params[:auth_result]
    #
    # if auth_result == 'failed'
    #   render text: 'auth failed'
    #   return
    # end
    #
    # @client = WifiClient.find_by(mac: client_mac)
    # user_id = @client.try(:user_id)
    #
    # if user_id.present?
    #   render status: :ok
    #   return
    # end
    #
    # # 下载APP
    # @app_version = AppVersion.latest_version
    # if @app_version.file
    #   redirect_to @app_version.file.url
    # else
    #   render status: :ok
    # end
  end
  
  private
  
  def first_login_auth
    # token = params[:token]
    # time = session[token.to_sym]
    # if time > Time.zone.now
    #   auth = 1
    #   puts '1. ------'
    # else
    #   session[token.to_sym] = nil
    #   auth = 0
    #   puts '2. ------'
    # end
    
    render text: "Auth: 1"
  end
  
  def app_auth
    auth = 0
    
    if SiteConfig.banned_macs.blank?
      mac_banned = false
    elsif SiteConfig.banned_macs.split(',').include?(params[:mac])
      mac_banned = true
    else
      mac_banned = false
    end
    
    if !client = WifiClient.find_by(token: params[:token])
      puts "Invalid token: #{params[:token]}"
    else
      case params[:stage]
      when 'login' # 初次认证登录
        if client.expired? or client.used?
          puts "Tried to login with used or expired token: #{params[:token]}"
        elsif mac_banned
          puts "Banned MAC tried logging in at " + Time.now.to_s + " with MAC: " + params[:mac]
        else
          client.use!
          auth = 1
        end
      when 'counters' # 已经认证登录过
        if !client.expired?
          if !mac_banned
            auth = 1
            client.update_attributes({
              ip: params[:ip],
              incoming: params[:incoming],
              outgoing: params[:outgoing]
            })
          else
            client.expire!
          end
        end
      when 'logout' # 已经退出登录
        puts "Logging out: #{params[:token]}"
        client.expire!
      else
        puts "Invalid stage: #{params[:stage]}"
      end
    end
    
    render text: "Auth: #{auth}"
  end
  
  def auth_1_0
    auth = 0
    
    # mac_banned = SiteConfig.banned_macs and SiteConfig.banned_macs.split(',').include?(params[:mac])
    if SiteConfig.banned_macs.blank?
      mac_banned = false
    elsif SiteConfig.banned_macs.split(',').include?(params[:mac])
      mac_banned = true
    else
      mac_banned = false
    end
    
    if !connection = Connection.find_by(token: params[:token])
      puts "Invalid token: #{params[:token]}"
    else
      case params[:stage]
      when 'login'
        if connection.expired? or connection.used?
          puts "Tried to login with used or expired token: #{params[:token]}"
        elsif mac_banned
          puts "Banned MAC tried logging in at " + Time.now.to_s + " with MAC: " + params[:mac]
        else
          connection.use!
          auth = 1
        end
      when 'counters'
        if !connection.expired?
          if !mac_banned
            auth = 1
            connection.update_attributes({
              mac: params[:mac],
              ip: params[:ip],
              incoming_bytes: params[:incoming],
              outgoing_bytes: params[:outgoing]
            })
          else
            connection.expire!
          end
        end
      when 'logout'
        puts "Logging out: #{params[:token]}"
        connection.expire!
      else
        puts "Invalid stage: #{params[:stage]}"
      end
    end
    
    render text: "Auth: #{auth}"
  end
  
end