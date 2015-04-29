# Include Bundler Extensions
# Comment out the following line if you're not using Bundler.
require "bundler/capistrano"

# Application Settings
set :application, "PIFA"
set :repository,  "git@github.com:redtettemer/PIFA-2013.git"
set :deploy_to, "/var/www/rails_apps/#{application}"
set :unicorn_pid, "#{deploy_to}/shared/pids/unicorn.pid"
set :unicorn_rails, "/usr/local/rbenv/shims/unicorn_rails"
set :bundle, "/usr/local/rbenv/shims/bundle"

role :app, "vs829458.blueboxgrid.com"
role :web, "vs829458.blueboxgrid.com"
role :db,  "vs829458.blueboxgrid.com", :primary => true

# Required for the Asset Pipeline
load 'deploy/assets'

# Repository Settings
set :scm, "git"
set :checkout, 'export'
set :copy_exclude, ".git/*"
set :deploy_via, :remote_cache

# General Settings
set :user, "deploy"
default_run_options[:pty] = true
set :keep_releases, 5
set :use_sudo, false
ssh_options[:forward_agent] = true

# Hooks
after "deploy", "deploy:cleanup"
after "deploy:update_code", "deploy:web:update_maintenance_page"
#after "deploy:update_code", "deploy:secondary_symlink"
before "deploy:assets:precompile", "deploy:secondary_symlink"

namespace :deploy do
  task :secondary_symlink, :except => { :no_release => true } do
    run "ln -nfs #{deploy_to}/shared/config/database.yml #{release_path}/config/database.yml"
    run "ln -nfs #{deploy_to}/shared/config/unicorn.rb #{release_path}/config/unicorn.rb"
    run "ln -nfs #{deploy_to}/shared/sockets #{release_path}/tmp/sockets"
  end
 
  task :start,  :except => { :no_release => true} do
    run "#{bundle} exec #{unicorn_rails} -c #{deploy_to}/current/config/unicorn.rb -D -E production"
  end
 
  task :stop, :except => { :no_release => true} do
    run "kill `cat #{unicorn_pid}`" 
  end
  
  task :restart, :except => { :no_release => true } do
    run "kill -s USR2 `cat #{unicorn_pid}`"
  end
 
  task :hard_restart, :roles => :app, :except => { :no_release => true } do
    stop
    start
  end

end

# Disable the built in disable command and setup some intelligence so we can have images.
disable_path = "#{shared_path}/system/maintenance/"
namespace :deploy do
  namespace :web do
    desc "Disables the website by putting the maintenance files live."
    task :disable, :except => { :no_release => true } do
      on_rollback { run "mv #{disable_path}index.html #{disable_path}index.disabled.html" }
      run "mv #{disable_path}index.disabled.html #{disable_path}index.html"
    end

    desc "Enables the website by disabling the maintenance files."
    task :enable, :except => { :no_release => true } do
        run "mv #{disable_path}index.html #{disable_path}index.disabled.html"
    end

    desc "Copies your maintenance from public/maintenance to shared/system/maintenance."
    task :update_maintenance_page, :except => { :no_release => true } do
      run "rm -rf #{shared_path}/system/maintenance/; true"
      run "mkdir -p #{release_path}/public/maintenance"
      run "touch #{release_path}/public/maintenance/index.html.disabled"
      run "cp -r #{release_path}/public/maintenance #{shared_path}/system/"
    end
  end
end
