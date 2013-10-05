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

set :shared_children,  %w(public/system log tmp/pids public/files db/data config/keys)

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
  
  task :down do
    run "touch #{current_path}/tmp/down" 
  end
  task :up do
    run "rm #{current_path}/tmp/down" 
  end
  
  # Use a shared config directory. Run cap deploy:configs:setup first.
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
end
