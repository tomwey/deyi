class CreateQrcodeJob < ActiveJob::Base
  queue_as :scheduled_jobs

  def perform(user)
    if user.blank? or user.uid.blank?
      return
    end
    
    text = Setting.upload_url + "/shoutu?uid=#{user.uid}"
    qr = Qrcode::Code.new(text)
    
    dest_dir = Rails.public_path.to_s + "/uploads/user/#{user.uid}"
    FileUtils.mkdir_p(dest_dir) unless File.exists?(dest_dir)
    
    dest_path = "#{dest_dir}/qrcode.png"
    logo_file = Rails.root.to_s + '/app/assets/images/logo.png'
    qr.generate(dest_path, logo_file)
  end
  
end