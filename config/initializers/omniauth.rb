Rails.application.config.middleware.use OmniAuth::Builder do
  # provider :facebook, ENV['FACEBOOK_KEY'], ENV['FACEBOOK_SECRET']
  provider :facebook, '1070295626337515', 'ccf7d1a31233bd5188c522733e2b95e2', callback_path: '/users/auth/facebook/callback', image_size: :normal, info_fields: 'first_name,last_name,email'
end