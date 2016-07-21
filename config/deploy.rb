# config valid only for current version of Capistrano
lock '3.4.0'

set :application, 'bizport'
set :repo_url, 'git@github.com:rossettistone/bizport.git'

set :rbenv_ruby, File.read('.ruby-version').strip

set :puma_bind, 'tcp://0.0.0.0:9951'

# Notify Bugsnag of new releases
require 'bugsnag/capistrano'
set :bugsnag_api_key, "7af36b6215b3d92b6cd8f20a3ceb6a26"

# Notify NewRelic of new releases
require 'new_relic/recipes'
after "deploy:updated", "newrelic:notice_deployment"

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, '/var/www/my_app_name'

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml', 'public/sitemap.xml.gz')

# Default value for linked_dirs is []
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

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
