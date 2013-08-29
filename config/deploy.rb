load 'deploy/assets'
require 'rvm/capistrano'
require "rvm/capistrano/alias_and_wrapp"

set :rvm_ruby_string, :local
set :rvm_autolibs_flag, "packages"

set :application, "tmuxme"
set :repository,  "git@github.com:realpractice/tmuxme.git"
set :user, "deploy"
set :ssh_options, { :forward_agent => true}


set :use_sudo, false

# set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

server "tmux.me", :app, :web, :db, :primary => true

before 'deploy', 'rvm:create_alias'
before 'deploy', 'rvm:create_wrappers'
before 'deploy:setup', 'rvm:install_rvm'
before 'deploy:setup', 'rvm:install_ruby'

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end