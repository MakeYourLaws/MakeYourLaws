# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }

set :rvm_ruby_string, 'rbx'
set :rvm_type, :system # using system level, not userspace, install of rvm

set :application, 'makeyourlaws'  # Required

set :ci_client, 'travis'
set :ci_repository, 'MakeYourLaws/MakeYourLaws'

set :scm, :git # :git, :darcs, :subversion, :cvs
set :repo_url, 'git://github.com/MakeYourLaws/MakeYourLaws.git'
set :branch, 'master'
set :git_enable_submodules, 1

# set :gateway, "gate.host.com"  # default to no gateway
set :runner, 'makeyourlaws'
set :deploy_to, '/home/makeyourlaws/makeyourlaws.org/' # must be path from root
set :deploy_via, :remote_cache

set :rails_env, 'production'

set :ssh_options,
    user:          'makeyourlaws',
    compression:   false,
    # keys:  %w(~/.ssh/myl_deploy),
    forward_agent: true # make sure you have an SSH agent running locally
# auth_methods: %w(password)
# port: 25

server '173.255.252.140', roles: [:web, :app, :db, :resque_worker, :resque_scheduler]

set :workers,  '*' => 2

# Uncomment this line if your workers need access to the Rails environment:
set :resque_environment_task, true

# set :format, :pretty
# set :log_level, :debug
set :pty, true  # turning on pty allows resque workers to be started without making capistrano hang

# set :linked_files, %w{config/database.yml}
set :linked_dirs,  %w(bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system
                      public/assets public/files db/data config/keys)

set :keep_releases, 15

# not cap3 compatible yet https://github.com/railsware/capistrano-ci/pull/4
# before :deploy, "ci:verify"

namespace :resque do
  resque_options = { start:         'Starts resque-pool daemon.',
                     stop:          'Sends INT to resque-pool daemon to close master, ' \
                                     'letting workers finish their jobs.',
                     graceful_stop: 'Gracefully stop resque-pool',
                     quick_stop:    'Quick stop resque-pool',
                     reload:        'Reloads resque-pool for log rotation etc',
                     restart:       'Restart resque-pool',
                     status:        "Checks resque-pool's status" }

  resque_options.each do |cmd, txt|
    desc txt
    task cmd do
      on roles(:resque_worker) do
        execute "service makeyourlaws_resque #{cmd}"
      end
    end
  end

  desc 'List all resque processes.'
  task :ps do
    on roles(:resque_worker) do
      info capture('ps -ef f | grep -E "[r]esque-(pool|[0-9])" || ' \
                    'echo "No workers found" && exit 1')
    end
  end

  desc 'List all resque pool processes.'
  task :psm do
    on roles(:resque_worker) do
      info capture('ps -ef f | grep -E "[r]esque-pool" || echo "No resque-pool found" && exit 1')
    end
  end

  namespace :scheduler do
    resque_scheduler_options = { status:  'See current scheduler status',
                                 status:  'Starts resque scheduler',
                                 stop:    'Stops resque scheduler',
                                 restart: 'Restarts resque scheduler' }

    resque_scheduler_options.each do |cmd, txt|
      desc txt
      task cmd do
        on roles(:resque_scheduler) do
          execute "service makeyourlaws_resque_scheduler #{cmd}"
        end
      end
    end
  end

end

namespace :deploy do
  # task :restart do
  #   on roles(:app), in: :sequence, wait: 5 do
  #     within fetch(:release_path) do
  #       execute :touch, "tmp/restart.txt"
  #     end
  #   end
  # end

  after :publishing, 'deploy:restart'

  # after :start, 'puma:start'
  # after :stop, "puma:stop"
  after :restart, 'puma:restart'

  after :restart, 'resque:restart'
  after :restart, 'resque:scheduler:restart'

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      execute 'curl -s https://makeyourlaws.org > /dev/null' # Warm up the server
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

  after :finishing, 'deploy:cleanup'
  after :finishing, 'airbrake:deploy'
  after :finishing, 'puma:status'
  after :finishing, 'resque:status'
  after :finishing, 'resque:scheduler:status'

  # # https://github.com/capistrano/capistrano/issues/478#issuecomment-24983528
  # namespace :assets do
  #   task :update_asset_mtimes, :roles => lambda { assets_role },
  #                              :except => { :no_release => true } do
  #   end
  # end
  # set :normalize_asset_timestamps, %{public/images public/javascripts public/stylesheets}

  task :down do
    on roles(:app) do
      execute :mv, "#{release_path}/public/maintenance_standby.html",
              "#{release_path}/public/maintenance.html"
    end
  end
  task :up do
    on roles(:app) do
      execute :mv, "#{release_path}/public/maintenance.html",
              "#{release_path}/public/maintenance_standby.html"
    end
  end

  # after :restart, "deploy:restart_mail_fetcher"
  # after :finishing, "newrelic:notice_deployment"

  task :restart_mail_fetcher do
    on roles(:app) do
      within fetch(:release_path) do
        with rails_env: fetch(:rails_env) do
          execute 'script/mail_fetcher restart'
        end
      end
    end
  end
end

require './config/boot'
