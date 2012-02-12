$:.unshift(File.expand_path('./lib', ENV['rvm_path'])) # Add RVM's lib directory to the load path.
require "rvm/capistrano"
require "bundler/capistrano"
load "deploy/assets"

set :rvm_ruby_string, 'ruby-1.9.3'
set :application, "battlemasters"
set :repository,  "git@github.com:BinaryMuse/battlemasters-lfg.git"
set :user,        "battlemasters"
set :deploy_to,   "/var/www/vhosts/battlemasters.org/"
set :scm,         :git
set :use_sudo,    false

server "muse", :app, :web, :db, :primary => true

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
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
after  "deploy:finalize_update", "db:symlink"
after  "db:symlink", "deploy:migrate"
