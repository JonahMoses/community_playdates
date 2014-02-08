class User

  attr_reader :email, :provider, :uid, :name, :oauth_token, :oauth_expires_at

  def initialize(auth)
    @provider         = auth[:provider]
    @uid              = auth[:uid]
    @name             = auth[:name]
    @email            = auth[:email]
    @oauth_token      = auth[:oauth_token]
    @oauth_expires_at = auth[:oauth_expires_at]
  end

end
