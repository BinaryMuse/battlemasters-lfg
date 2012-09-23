require "rvm/capistrano"
require "bundler/capistrano"
require "whenever/capistrano"

set :rvm_ruby_string,  "ruby-1.9.3"
set :rvm_type,         :system
set :application,      "battlemasters"
set :repository,       "git@github.com:BinaryMuse/battlemasters-lfg.git"
set :user,             "battlemasters"
set :deploy_to,        "/var/www/vhosts/battlemasters.org/"
set :scm,              :git
set :use_sudo,         false
set :whenever_command, "bundle exec whenever"

server "muse", :app, :web, :db, :primary => true

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end

  desc "Symlink secrets not stored in repository"
  task :symlink_secrets do
    run "ln -nfs #{shared_path}/config/initializers/secret_token.rb #{release_path}/config/initializers/secret_token.rb"
  end
end

namespace :db do
  desc "Symlink the shared database.yml to the application config directory"
  task :symlink do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  end
end

namespace :rvm do
  desc 'Trust .rvmrc file'
  task :trust_rvmrc do
    run "rvm rvmrc trust #{current_release}"
  end
end

before "deploy:finalize_update", "rvm:trust_rvmrc"
after  "deploy:finalize_update", "deploy:symlink_secrets"
after  "deploy:finalize_update", "db:symlink"
after  "db:symlink", "deploy:migrate"
