Tumblr.configure do |config|
  config.consumer_key = ENV["tumblr_consumer_key"]
  config.consumer_secret = ENV["tumblr_consumer_secret"]
  config.oauth_token = ENV["tumblr_oauth_token"]
  config.oauth_token_secret = ENV["tumblr_oauth_token_secret"]
end
