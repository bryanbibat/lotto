require "bundler/capistrano"

set :deploy_via, :remote_cache
set :application, "lotto"
set :repository,  "git://github.com/bryanbibat/lotto.git"
set :deploy_to, "/home/bry/capistrano/lotto"

set :scm, :git

default_run_options[:pty] = true

server "bryanbibat.net", :app, :web, :db, :primary => true
set :user, "bry"
set :use_sudo, false

depend :remote, :gem, "bundler"
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end

after "deploy:symlink", :create_symlink_to_log 


task :create_symlink_to_log do
  run "cd #{current_path}; rm -rf log; ln -s #{shared_path}/log log"
end
