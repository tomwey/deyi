class WifiDog::WifiController < ApplicationController
  def auth
    auth_1_0
  end
  
  def control86
    puts params
    render text: 'ok'
  end
    
  def ping
    active_node = AccessNode.find_by(mac: params[:gw_id])
    unless active_node.blank?
      active_node.update_attributes({
        sys_uptime: params[:sys_uptime],
        sys_load: params[:sys_load],
        sys_memfree: params[:sys_memfree],
        wifidog_uptime: params[:wifidog_uptime],
        remote_addr: request.remote_addr,
        last_seen: Time.now
      })
    end
    render text: "Pong"
  end
  
  def portal
    # 重定向到一个固定的欢迎页面，有可能是下载app的广告页面
    # redirect_to 'http://'
  end
  
  private
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