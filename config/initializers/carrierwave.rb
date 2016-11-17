CarrierWave.configure do |c|
  c.storage = :aws
  c.aws_bucket = ENV["AWS_BUCKET"]
  c.aws_acl = "public_read"

  c.aws_credentials = {
    access_key_id: ENV["AWS_ACCESS_KEY"],
    secret_access_key: ENV["AWS_SECRET_KEY"],
    region: ENV["AWS_REGION"]
  }
end
