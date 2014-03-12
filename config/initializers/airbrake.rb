Airbrake.configure do |config|
  config.api_key = Keys.get('airbrake')
  config.secure = true
end
