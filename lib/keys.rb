module Keys
  # Get the key for a given environment (falling back to the general one)
  # Note that keys are listed in .gitignore, so should not be committed.
  # Instead, they are manually scp'd to the Capistrano /shared/config/keys directory on the server.
  def self.get name, environment = Rails.env
    file = File.join(Rails.root, "config", "keys", name + '.' + environment)
    key = if File.exist?(file)
      IO.read(file).strip
    else
      file = File.join(Rails.root, "config", "keys", name)
      IO.read(file).strip if File.exist?(file)
    end
    
    if !key
      raise "Key #{name} not found for #{environment} environment. 
      Set it in Rails console using Keys.set(\"#{name}\", \"SECRET-KEY\"[, \"#{environment}\"]) 
      Alternately, run echo \"SECRET-KEY\" > config/keys/#{name}.#{environment} from shell."
    else
      key
    end
  end
  
  # Name your key some_key.production (.test, .development) if you want it environment-specific.
  def self.set name, key, environment = nil
    name = "#{name}.#{environment}" if environment
    file = File.join(Rails.root, "config", "keys", name)
    File.open(file, 'w') {|f| f.write(key) }
  end
end