class User < ActiveRecord::Base
  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      user.provider         = auth[:provider]
      user.uid              = auth[:uid]
      user.name             = auth[:name]
      user.email            = auth[:email]
      user.oauth_token      = auth[:oauth_token]
      user.oauth_expires_at = auth[:oauth_expires_at]
      user.save!
    end
  end
end
