# In config/initializers/omniauth.rb
Rails.application.config.middleware.use OmniAuth::Builder do
	provider :facebook, ENV['FACEBOOK_APP_KEY'], ENV['FACEBOOK_APP_SECRET'],
	scope: 'email,public_profile', display: 'popup', info_fields: 'email,name'
end