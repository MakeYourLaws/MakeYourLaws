# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }

set :rvm_ruby_string, '2.0.0'
set :rvm_type, :system # using system level, not userspace, install of rvm

set :application, "makeyourlaws"  # Required

set :scm, :git # :git, :darcs, :subversion, :cvs
set :repo_url, "git://github.com/MakeYourLaws/MakeYourLaws.git"
set :branch, "master"
set :git_enable_submodules, 1

# set :gateway, "gate.host.com"  # default to no gateway
set :user, "makeyourlaws"
set :runner, "#{user}"
set :ip, '173.255.252.140' # IP of server. Better than using DNS lookups, if it's static
role :all, '173.255.252.140' # again, IP > DNS
set :deploy_to, "/home/#{user}/makeyourlaws.org/" # must be path from root
set :deploy_via, :remote_cache
default_run_options[:pty] = true  # Uncomment if on SunOS (eg Joyent) - http://groups.google.com/group/capistrano/browse_thread/thread/13b029f75b61c09d
# set :use_sudo, false # sudo is false on DreamHost
set :ssh_options, {
  # keys:  %w(~/.ssh/myl_deploy),
  forward_agent: true, # make sure you have an SSH agent running locally
  # auth_methods: %w(password)
  # port: 25
}

# set :format, :pretty
# set :log_level, :debug
# set :pty, true

# set :linked_files, %w{config/database.yml}
set :linked_dirs,  %w(bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system public/files db/data config/keys) # formerly shared_children

set :default_env, { path: "/home/#{user}/.gems/bin/:/usr/local/bin:/usr/bin:/bin:$PATH" }
# set :keep_releases, 5

namespace :deploy do
  task :restart, :roles => :app do
    on roles(:app), in: :sequence, wait: 5 do
      deploy.passenger.restart
      run "curl -s https://makeyourlaws.org > /dev/null" # Make the server boot up
    end
  end
  
  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

  after :finishing, 'deploy:cleanup'
  
  
  # # https://github.com/capistrano/capistrano/issues/478#issuecomment-24983528
  # namespace :assets do
  #   task :update_asset_mtimes, :roles => lambda { assets_role }, :except => { :no_release => true } do
  #   end
  # end
  # set :normalize_asset_timestamps, %{public/images public/javascripts public/stylesheets}
  
  task :down do
    run "touch #{current_path}/tmp/down" 
  end
  task :up do
    run "rm #{current_path}/tmp/down" 
  end
  
  # after "deploy:restart", "deploy:restart_mail_fetcher"
  after "deploy:finalize_update", "newrelic:notice_deployment"
  
  task :restart_mail_fetcher, :roles => :app do
    within fetch(:latest_release_directory) do
      with rails_env: fetch(:rails_env) do
        run "script/mail_fetcher restart"
      end
    end
  end
  
  namespace :passenger do
    desc "Restart using Passenger" 
    task :restart, :roles => :app do
      run "touch #{current_path}/tmp/restart.txt" 
    end
  end
end
