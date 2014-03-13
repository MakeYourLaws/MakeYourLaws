# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }

set :rvm_ruby_string, '2.1.1'
set :rvm_type, :system # using system level, not userspace, install of rvm

set :application, "makeyourlaws"  # Required

set :scm, :git # :git, :darcs, :subversion, :cvs
set :repo_url, "git://github.com/MakeYourLaws/MakeYourLaws.git"
set :branch, "master"
set :git_enable_submodules, 1

# set :gateway, "gate.host.com"  # default to no gateway
set :runner, "makeyourlaws"
set :deploy_to, "/home/makeyourlaws/makeyourlaws.org/" # must be path from root
set :deploy_via, :remote_cache

set :ssh_options, {
  user: "makeyourlaws",
  compression: false,
  # keys:  %w(~/.ssh/myl_deploy),
  forward_agent: true, # make sure you have an SSH agent running locally
  # auth_methods: %w(password)
  # port: 25
}


server '173.255.252.140', roles: [:web, :app, :db, :workers, :resque_worker, :resque_scheduler]

# capistrano-resque seems to have a problem w/ forking to create multiple workers
set :workers, { "*" => 1 }

# Uncomment this line if your workers need access to the Rails environment:
# set :resque_environment_task, true

# set :format, :pretty
# set :log_level, :debug
# set :pty, true

# set :linked_files, %w{config/database.yml}
set :linked_dirs,  %w(bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system public/files db/data config/keys) # formerly shared_children

set :keep_releases, 15

namespace :deploy do
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      within fetch(:release_path) do
        execute :touch, "tmp/restart.txt"
        execute "curl -s https://makeyourlaws.org > /dev/null" # Make the server boot up
      end
    end
  end

  after :publishing, 'deploy:restart'

  after :restart, "airbrake:deploy"
  after :restart, "resque:restart"

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
    on roles(:app) do
      within fetch(:release_path) do
        execute :touch, "tmp/down"
      end
    end
  end
  task :up do
    on roles(:app) do
      within fetch(:release_path) do
        execute :rm, "tmp/down"
      end
    end
  end

  # after :restart, "deploy:restart_mail_fetcher"
  # after :finishing, "newrelic:notice_deployment" # newrelic isn't cap 3 compatible yet

  task :restart_mail_fetcher do
    on roles(:app) do
      within fetch(:release_path) do
        with rails_env: fetch(:rails_env) do
          execute "script/mail_fetcher restart"
        end
      end
    end
  end
end

require './config/boot'