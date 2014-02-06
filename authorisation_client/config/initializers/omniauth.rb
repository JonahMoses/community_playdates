OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '226856227502795', 'c30262ea2c0c950e6e92e7a295fe1b68'
end
