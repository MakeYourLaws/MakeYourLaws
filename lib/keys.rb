# Note: this is called from things where Rails is *not* yet loaded, which is why we can't use Rails.root
module Keys
  @keys_dir =  File.join File.dirname(__FILE__), '..', 'config', 'keys'   
  @keys_dir = File.join File.dirname(__FILE__), 'config', 'keys' unless Dir.exists?(@keys_dir)

  # Get the key for a given environment (falling back to the general one)
  # Note that keys are listed in .gitignore, so should not be committed.
  # Instead, they are manually scp'd to the Capistrano /shared/config/keys directory on the server.
  def self.get name, environment = nil
    environment ||= if defined? Rails
      Rails.env
    else
      'production'
    end
    
    file = File.join(@keys_dir, name + '.' + environment)
    key = if File.exist?(file)
      IO.read(file).strip
    else
      file = File.join(@keys_dir, name)
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
    file = File.join(@keys_dir, name)
    File.open(file, 'w') {|f| f.write(key) }
  end
end