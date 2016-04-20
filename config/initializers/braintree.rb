Braintree::Configuration.environment  = ENV['braintree_env']
Braintree::Configuration.merchant_id   = ENV['braintree_merchant_id']
Braintree::Configuration.public_key   = ENV['braintree_api_public']
Braintree::Configuration.private_key  = ENV['braintree_api_secret']
