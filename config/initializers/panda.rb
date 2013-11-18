Panda.configure do
  access_key ENV['PANDA_ACCESS_KEY']
  secret_key ENV['PANDA_SECRET_KEY']
  cloud_id ENV['PANDA_CLOUD_ID']
  # Uncomment below if you have register for an EU account
  # api_host "api-eu.pandastream.com"
end

# Panda.configure(YAML.load_file(Rails.root.join("config/panda.yml"))[Rails.env])
