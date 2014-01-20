require 'bundler/capistrano'

set :application, "PublicWorks"
set :repository,  "git@github.com:blingoart/publicworks.git"


# set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`
set :scm, :git
#set :git_shallow_clone, 1
set :keep_releases, 5

#role :web, "your web-server here"                          # Your HTTP server, Apache/etc
#role :app, "your app-server here"                          # This may be the same as your `Web` server
#role :db,  "your primary db-server here", :primary => true # This is where Rails migrations will run
#role :db,  "your slave db-server here"

task :staging do
  server "173.255.227.40", :app, :web, :db, :primary => true
  set :ssh_options, { :forward_agent => true }
  set :default_shell, '/bin/bash -l'
  set :user, "ted"
  set :branch, "staging"
  set :deploy_to, "/var/www/staging.publicworks.io"
  set :rails_env, "staging"
  set :use_sudo, false
  set :deploy_via, :remote_cache
  #default_run_options[:shell] = '/bin/bash --login'
end

task :production do
  server "173.255.227.40", :app, :web, :db, :primary => true
  set :ssh_options, { :forward_agent => true }
  set :default_shell, '/bin/bash -l'
  set :user, "ted"
  set :branch, "master"
  set :deploy_to, "/var/www/publicworks.io"
  set :rails_env, "production"
  set :use_sudo, false
  set :deploy_via, :remote_cache
end


#task :production do
#  role :web, "209.251.186.129:7000" # gopogo [mongrel] [gopogo-mysql-production-master]
#  role :app, "209.251.186.129:7000", :passenger => true
#  role :db , "209.251.186.129:7000", :primary => true
#  role :app, "209.251.186.129:7001", :passenger => true
#  set :rails_env, "production"
#  set :environment_database, defer { production_database }
#  set :environment_dbhost, defer { production_dbhost }
#end
#task :staging do
#  role :web, "209.251.187.229:7000" # gopogo [mongrel] [gopogo-mysql-staging-master]
#  role :app, "209.251.187.229:7000", :passenger => true
#  role :db , "209.251.187.229:7000", :primary => true
#  set :rails_env, "staging"
#  set :environment_database, defer { staging_database }
#  set :environment_dbhost, defer { staging_dbhost }
#end


#after "deploy", "passenger:restart"
#after "deploy", "rvm:trust_rvmrc"

# if you want to clean up old releases on each deploy uncomment this:
after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
   task :start do ; end
   task :stop do ; end
   task :restart, :roles => :app, :except => { :no_release => true } do
     #run "touch #{current_path}/tmp/restart.txt"
     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
   end
end

namespace :rvm do
   task :trust_rvmrc do
      run "rvm rvmrc trust #{release_path}"
   end
end

