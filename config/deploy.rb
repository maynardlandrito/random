require "rvm/capistrano"
require 'bundler/capistrano'

set :user, 'maynard2'
set :domain, '50.56.246.165'
set :applicationdir, "/home/maynard2/connect4app"
 
set :scm, 'git'
set :repository,  "git@github.com:maynardlandrito/random.git"
#111set :git_enable_submodules, 1 # if you have vendored rails
set :branch, 'master'
#set :git_shallow_clone, 1
set :scm_verbose, true

ssh_options[:forward_agent] = true
 
set :rvm_ruby_string, '1.9.3@global'
set :rvm_type, :user

# roles (servers)
role :web, domain
role :app, domain
role :db,  domain, :primary => true
 
# deploy config
set :deploy_to, applicationdir
set :deploy_via, :export
#set :use_sudo, false
 
# additional settings
default_run_options[:pty] = true  # Forgo errors when deploying from windows
#ssh_options[:keys] = %w(/home/user/.ssh/id_rsa)            # If you are using ssh_keysset :chmod755, "app config db lib public vendor script script/* public/disp*"set :use_sudo, false
 
# Passenger
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end