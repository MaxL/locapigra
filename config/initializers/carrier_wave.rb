if Rails.env.production?
  CarrierWave.configure do |config|
    config.fog_credentials = {
      # Amazon S3
      :provider                    => 'AWS',
      :aws_access_key_id           => ENV['S3_ACCESS_KEY'],
      :aws_secret_access_key_id    => ENV['S3_SECRET_KEY'],
      :region                      => ENV['S3_REGION']
    }

    config.cache_dir = "#{Rails.root}/tmp/uploads"                  # To let CarrierWave work on heroku

    config.fog_directory          = ENV['S3_BUCKET']
  end
end
