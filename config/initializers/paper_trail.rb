class Version < ActiveRecord::Base
  if defined?(Rails::Console)
    PaperTrail.whodunnit = "#{`whoami`.strip rescue 'unknown'}: console"
  elsif File.basename($0) == "rake"
    PaperTrail.whodunnit = "#{`whoami`.strip rescue 'unknown'}: rake #{ARGV.join ' '}"
  end
  
  # attr_accessible :ip
end
