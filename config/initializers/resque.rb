Dir[File.join(Rails.root, 'app', 'workers', '*.rb')].each { |file| require file }
config = YAML.load(File.open("#{Rails.root}/config/resque.yml"))[Rails.env]
Resque.redis = Redis.new(host: config['host'], port: config['port'], db: config['db'])
