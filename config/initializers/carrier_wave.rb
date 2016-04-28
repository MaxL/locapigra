if Rails.env.production?
  CarrierWave.configure do |config|
    config.root = Rails.root.join('tmp') # adding these...
    config.cache_dir = 'carrierwave' # ...two lines

    config.fog_credentials = {
      # Amazon S3
      :provider                    => 'AWS',
      :aws_access_key_id           => ENV["s3_access_key"],
      :aws_secret_access_key       => ENV["s3_secret_key"],
      :region                      => ENV["s3_region"]
    }

    config.fog_directory          = ENV["s3_bucket"]
  end
end
