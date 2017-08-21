CarrierWave.configure do |config|
  config.fog_provider = 'fog/aws'
  config.fog_credentials = {
    provider:              'AWS',
    aws_access_key_id:     ENV['AWS_ACCESS_KEY'],
    aws_secret_access_key: ENV['AWS_SECRET'],
    region:                'us-east-2',
  }
  config.fog_directory  = ENV['S3_BUCKET']
  config.fog_public     = true
  config.fog_attributes = {}
end
