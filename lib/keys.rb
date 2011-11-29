module Keys
  # Get the key for a given environment (falling back to the general one)
  # Note that keys are listed in .gitignore, so should not be committed.
  # Instead, they are manually scp'd to the Capistrano /shared/config/keys directory on the server.
  def self.get name, environment = Rails.env
    file = File.join(Rails.root, "config", "keys", name + '.' + environment)
    if File.exist?(file)
      IO.read(file).strip
    else
      file = File.join(Rails.root, "config", "keys", name)
      IO.read(file).strip if File.exist?(file)
    end
  end
  
  # Name your key some_key.production (.test, .development) if you want it environment-specific.
  def self.set name, key
    file = File.join(Rails.root, "config", "keys", name)
    File.open(file, 'w') {|f| f.write(key) }
  end
end