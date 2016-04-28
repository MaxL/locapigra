if Rails.env.production?
  CarrierWave.configure do |config|
    config.root = Rails.root.join('tmp') # adding these...
    config.cache_dir = 'carrierwave' # ...two lines

    config.fog_credentials = {
      # Amazon S3
      :provider                    => 'AWS',
      :aws_access_key_id           => s3_access_key,
      :aws_secret_access_key       => s3_secret_key,
      :region                      => s3_region
    }

    config.fog_directory          = s3_bucket
  end
end
