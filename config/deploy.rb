require "bundler/capistrano"
require 'new_relic/recipes'

# No need for mongrel cluster if using Phusion Passenger
# require 'mongrel_cluster/recipes'

set :rvm_ruby_string, '2.0.0'
require "rvm/capistrano" 
set :rvm_type, :system # using system level, not userspace, install of rvm

# Application
set :application, "makeyourlaws"  # Required
# deploy_to must be path from root

# Repo
set :scm, :git # :git, :darcs, :subversion, :cvs
# set :svn, /path/to/svn # or :darcs or :cvs or :git; defaults to checking PATH
set :repository, "git://github.com/MakeYourLaws/MakeYourLaws.git"
set :branch, "master"
set :git_enable_submodules, 1

# Server
# set :gateway, "gate.host.com"  # default to no gateway
set :user, "makeyourlaws"
set :runner, "#{user}"
set :deploy_to, "/home/#{user}/makeyourlaws.org/" # defaults to "/u/apps/#{application}"
set :deploy_via, :remote_cache
# set :mongrel_conf, "#{deploy_to}/current/config/mongrel_cluster.yml"
default_run_options[:pty] = true  # Uncomment if on SunOS (eg Joyent) - http://groups.google.com/group/capistrano/browse_thread/thread/13b029f75b61c09d
set :use_sudo, false # sudo is false on DreamHost
ssh_options[:forward_agent] = true # make sure you have an SSH agent running locally
# ssh_options[:keys] = %w(~/.ssh/myl_deploy)
# ssh_options[:port] = 25

default_environment['PATH'] = "/home/#{user}/.gems/bin/:/usr/local/bin:/usr/bin:/bin"

set :ip, '173.255.252.140' # IP of repository. Better than using DNS lookups, if it's static

# :no_release => true means that no code will be deployed to that box (but non-code tasks may run on it)
# :primary => true is currently unused, but could eg be for primary vs slave db servers
# you can have multiple "role :foo, "serverip", :options=>whatnot" lines, or server "ip", :role, :role2, :role3, :options=>foo
#server "#{ip}", :app, :db, :web, :primary => true # Single box that does it all
#role :app, "your app-server here"
#role :web, "your web-server here"
#role :db,  "your db-server here", :primary => true

server '173.255.252.140', :app, :db, :web, :primary => true # We have no access to DB server directly

# load 'deploy/assets' # executed by default as deploy:assets:precompile

# Choose your default deploy methods
namespace :deploy do
  task :restart, :roles => :app do
    deploy.passenger.restart
  end
  
  # Use a shared config directory. Run cap deploy:configs:setup first.
  after "deploy:finalize_update", "deploy:configs:symlink"
  after "deploy:finalize_update", "deploy:files:symlink"
  # after "deploy:restart", "deploy:restart_mail_fetcher"
  after "deploy:finalize_update", "newrelic:notice_deployment"
  
  task :restart_mail_fetcher, :roles => :app do
    run "cd #{release_path} && RAILS_ENV=#{fetch(:rails_env, "production")} script/mail_fetcher restart"
  end
  
  namespace :passenger do
    desc "Restart using Passenger" 
    task :restart, :roles => :app do
      run "touch #{current_path}/tmp/restart.txt" 
    end
  end
  
  namespace :files do
    desc "Creates symlinked shared public-files and private-data folders in shared folder"
    task :symlink, :roles => :app do
      run "rm -rf #{release_path}/public/files"
      run "mkdir -p #{shared_path}/public_files"
      run "chmod 775 #{shared_path}/public_files"
      run "ln -nfs #{shared_path}/public_files #{release_path}/public/files"
      
      run "rm -rf #{release_path}/db/data"
      run "mkdir -p #{shared_path}/data"
      run "chmod 770 #{shared_path}/data"
      run "ln -nfs #{shared_path}/data #{release_path}/db/data"
    end
  end
  
  namespace :configs do
    desc "Override config files w/ whatever's in the shared/config path (e.g. passwords, api keys)"
    task :symlink, :roles => :app do         
      # Be extra careful about exposing these
      run "chmod -R go-rwx #{shared_path}/config"
      
      # For all files in the shared config path, symlink in the shared config
      # For some reason, this Dir actually runs on the *local* system rather than the remote. Lame.
      #    Dir[File.join(shared_path, 'config', '**', '*.rb')].each do |c|
      # So here's a hack w/ find to do it the ugly way :(
      config_files = ''
      # Find all regular files (not directories) in the shared config path
      run("find #{shared_path}/config -type f") do |channel, stream, data| 
       config_files << data
      end
      # Extract the names of all config files
      config_files.strip.split("\n").map{|f| f.sub("#{shared_path}/config/", '').strip}.each do |c|
        run "ln -sf #{shared_path}/config/#{c} #{release_path}/config/#{c}" # And symlink in the server's version, overwriting (-f) whatever was there
      end
    end
  end
end
