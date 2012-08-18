class User < ActiveRecord::Base
  attr_accessible :email, :fb_id, :first_name, :last_name, :token
  
  def self.create_with_omniauth(fb_info)
    user = User.new
    
    #facebook credentials
    credentials = fb_info['credentials']
    user.token = credentials['token']
    user.expires_at = credentials['expires_at']
    
    #facebook user info
    user_info = fb_info['extra']['raw_info']
    user.first_name = user_info['first_name']
    user.last_name = user_info['last_name']
    user.fb_id = user_info['id']
    user.email = user_info['email']
    
    #save user in db
    user.save
    
    return user
  end
end
