# config valid only for current version of Capistrano
# lock '3.5.0'

set :user, 'ec2-user'
set :application, 'locapigra'
set :repo_url, 'git@github.com:MaxL/locapigra.git'

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, '/home/ec2-user/locapigra'

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: 'log/capistrano.log', color: :auto, truncate: :auto

# Default value for :pty is false
set :pty, true

# Default value for :linked_files is []
set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/application.yml')

# Default value for linked_dirs is []
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system', 'public/uploads', 'public/assets', 'downloads')

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

set :rbenv_type, :user
set :rbenv_ruby, '2.5.0'

set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w{rake gem bundle ruby rails}
set :rbenv_roles, :all # default value

set :puma_rackup, -> { File.join(current_path, 'config.ru') }
set :puma_state, "#{shared_path}/tmp/pids/puma.state"
set :puma_pid, "#{shared_path}/tmp/pids/puma.pid"
set :puma_bind, "unix://#{shared_path}/tmp/sockets/puma.sock"    #accept array for multi-bind
set :puma_conf, "#{shared_path}/puma.rb"
set :puma_access_log, "#{shared_path}/log/puma_error.log"
set :puma_error_log, "#{shared_path}/log/puma_access.log"
set :puma_role, :app

set :puma_threads, [0, 8]
set :puma_workers, 0
set :puma_worker_timeout, nil
set :puma_init_active_record, true
set :puma_preload_app, false

namespace :delayed_job do

  desc "Install Deployed Job executable if needed"
  task :install do
    on roles(delayed_job_roles) do |host|
      within release_path do
        # Only install if not already present
        unless test("[ -f #{release_path}/#{delayed_job_bin} ]")
          with rails_env: fetch(:rails_env) do
            execute :bundle, :exec, :rails, :generate, :delayed_job
          end
        end
      end
    end
  end

  before :start, :install
  before :restart, :install

end

namespace :deploy do

  desc 'Copy compiled error pages to public'
  task :copy_error_pages do
    on roles(:all) do
      %w(404 500).each do |page|
        page_glob = "#{current_path}/public/#{fetch(:assets_prefix)}/#{page}*.html"
        # copy newest asset
        asset_file = capture :ruby, %Q{-e "print Dir.glob('#{page_glob}').max_by { |file| File.mtime(file) }"}
        if asset_file
          execute :cp, "#{asset_file} #{current_path}/public/#{page}.html"
        else
          error "Error #{page} asset does not exist"
        end
      end
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

  after :finishing, :copy_error_pages

end
