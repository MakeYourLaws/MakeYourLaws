Rolify.configure do |config|
  # Dynamic shortcuts for User class (user.is_admin? like methods). Default is: false
  # Enable this feature _after_ running rake db:migrate as it relies on the roles table
  unless ( File.basename($0) == "rake" && ARGV.include?("db:migrate") )
    config.use_dynamic_shortcuts
  end
end
