
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2,
  client_id: ENV['GOOGLE_CLIENT_ID'],
  client_secret: ENV['GOOGLE_CLIENT_SECRET']
end
