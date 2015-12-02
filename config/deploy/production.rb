USER = 'zeal'
SERVER = 'in-staging.ru'
APP_NAME = 'hooters'
APP_SRV = "#{USER}@#{SERVER}"

role :app, APP_SRV
role :web, APP_SRV
role :db,  APP_SRV

set :application, APP_NAME
set :deploy_to, "/home/#{USER}/#{APP_NAME}/sites"
set :linked_dirs, %w{bin log pids tmp/cache tmp/sockets vendor/bundle public/system}
set :linked_files, %w{config/database.yml config/unicorn.rb config/secrets.yml}

# ===== UNICORN && NGINX================
load 'lib/capistrano/tasks/production_deploy.rake'

# ===== CACHE ==========================
namespace :cache do
  desc 'Clear cache'
  task :clear do
    on roles(:web) do
      within release_path do
        with rails_env: fetch(:rails_env) do
          execute :rake, 'cache:clear'
        end
      end
    end
  end
end

namespace :assets do
  desc 'Copy assets with non digests'
  task :no_digest do
    on roles(:web) do
      within release_path do
        with rails_env: fetch(:rails_env) do
          execute :rake, 'assets:no_digest'
        end
      end
    end
  end
end

namespace :deploy do
  before :compile_assets, 'cache:clear'
  after :compile_assets, 'assets:no_digest'
end

# ===== BUNDLER ============
set :bundle_binstubs, -> { shared_path.join('bin') }
set :bundle_gemfile, -> { release_path.join('Gemfile') }
set :bundle_path, -> { shared_path.join('bundle') }
set :bundle_without, []
set :bundle_flags, '--quiet'
set :bundle_env_variables, {}