Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['FACEBOOK_KEY'], ENV['FACEBOOK_SECRET'],
    scope: 'public_profile', image_size: {width: 20, height: 20}, info_fields: 'id,name'
end
