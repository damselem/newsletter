Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, ENV['GOOGLE_OAUTH_KEY'], ENV['GOOGLE_OAUTH_SECRET']
end
