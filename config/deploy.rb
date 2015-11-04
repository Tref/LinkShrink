require 'byebug'
# config valid only for current version of Capistrano
lock '3.4.0'

set :application, 'linkshrink'
set :repo_url, 'https://github.com/Tref/LinkShrink.git'

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp
set :branch, :master


# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, '/var/www/my_app_name'
set :deploy_to, '/home/deploy/linkshrink'


# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
set :pty, true

# Default value for :linked_files is []
# set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml')
set :linked_files, %w{config/database.yml config/application.yml}

# Default value for linked_dirs is []
# set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')
set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system public/uploads}


# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5
set :keep_releases, 5



# RBENV https://github.com/capistrano/rbenv/
set :rbenv_type, :user # or :system, depends on your rbenv setup
set :rbenv_ruby, '2.2.3'

# in case you want to set ruby version from the file:
# set :rbenv_ruby, File.read('.ruby-version').strip

set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w{rake gem bundle ruby rails}
set :rbenv_roles, :all # default value


#### PUMA https://github.com/seuros/capistrano-puma
set :puma_rackup, -> { File.join(current_path, 'config.ru') }
set :puma_state, "#{shared_path}/tmp/pids/puma.state"
set :puma_pid, "#{shared_path}/tmp/pids/puma.pid"
set :puma_bind, "unix://#{shared_path}/tmp/sockets/puma.sock"    #accept array for multi-bind
set :puma_conf, "#{shared_path}/puma.rb"
set :puma_access_log, "#{shared_path}/log/puma_error.log"
set :puma_error_log, "#{shared_path}/log/puma_access.log"
set :puma_role, :app
set :puma_env, fetch(:rack_env, fetch(:rails_env, 'production'))
set :puma_threads, [0, 8]
set :puma_workers, 0
set :puma_worker_timeout, nil
set :puma_init_active_record, true
set :puma_preload_app, false



#### DEPLOY
namespace :deploy do

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

end

# server 'example.com', roles: [:web, :app]
# server 'example.org', roles: [:db, :workers]
desc "Report Uptimes"
task :uptime do
  on roles(:all) do |host|
    execute :any_command, "with args", :here, "and here"
    info "Host #{host} (#{host.roles.to_a.join(', ')}):\t#{capture(:uptime)}"
  end
end

# desc "Rake db:seed"
# task :seed, :roles => :app, :except => { :no_release => true } do
#   run "cd #{deploy_to}/current"
#   run "bundle exec rake db:#{ENV['task']} RAILS_ENV=#{rails_env}"
# end

# role :demo, %w{example.com example.org example.net}
# task :seed do
#   on roles(:demo), in: :parallel do |host|
#     uptime = capture(:uptime)
#     puts "#{host.hostname} reports: #{uptime}"
#   end
# end



namespace :rake do

  # DB TASKS
  namespace :db do
    %w[create migrate reset rollback seed setup].each do |command|
      desc "Rake db:#{command}"
      task command do
        on roles(:app), except: {no_release: true} do
          run "cd #{deploy_to}/current"
          run "bundle exec rake db:#{ENV['task']} RAILS_ENV=#{rails_env}"
        end
      end
    end

    # desc "Rake db:seed"
    # task :seed do
    #   on roles(:app), except: {no_release: true} do
    #     # run "cd #{deploy_to}/current"
    #     # run "bundle exec rake db:#{ENV['task']} RAILS_ENV=#{rails_env}"
    #     # run "bundle exec rake db:#{ENV['task']} RAILS_ENV=#{rails_env}"
    #   end
    # end

  end

  # ASSET PRECOMPILE AND CLEAN TASK
  # namespace :assets do
  #   %w[precompile clean].each do |command|
  #     desc "Rake assets:#{command}"
  #     task command, roles: :app, except: {no_release: true} do
  #       run "cd #{deploy_to}/current"
  #       run "bundle exec rake assets:#{ENV['task']} RAILS_ENV=#{rails_env}"
  #     end
  #   end
  # end

end





