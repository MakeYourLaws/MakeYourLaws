# Note: this is called from things where Rails is *not* yet loaded,
#  which is why we can't use Rails.root
module Keys
  @keys_dir =  File.join File.dirname(__FILE__), '..', 'config', 'keys'
  @keys_dir = File.join File.dirname(__FILE__), 'config', 'keys' unless Dir.exist?(@keys_dir)

  # Get the key for a given environment (falling back to the general one)
  # Note that keys are listed in .gitignore, so should not be committed.
  # Instead, they are manually scp'd to the Capistrano /shared/config/keys directory on the server.
  def self.get name, environment = nil
    environment ||= (defined? Rails ? Rails.env : 'production')

    file = File.join(@keys_dir, name + '.' + environment)
    file = File.join(@keys_dir, name) unless File.exist?(file)
    fakefile = File.join(@keys_dir, name + '.fake')
    file = fakefile unless File.exist?(file)

    IO.write(fakefile, SecureRandom.hex(64).to_s) unless File.exist?(fakefile)

    if file == fakefile
      puts "Key #{name} not found for #{environment} environment.
      Set it in Rails console using Keys.set(\"#{name}\", \"SECRET-KEY\"[, \"#{environment}\"])
      Alternately, run echo \"SECRET-KEY\" > config/keys/#{name}.#{environment} from shell.
      In the meantime, we're using the .fake file."
    end

    IO.read(file).strip
  end

  # Name your key some_key.production (.test, .development) if you want it environment-specific.
  def self.set name, key, environment = nil
    name = "#{name}.#{environment}" if environment
    file = File.join(@keys_dir, name)
    File.open(file, 'w') { |f| f.write(key) }
  end
end
