node.override[:tilequeue][:cfg_path] = "#{node[:path][:etc]}/tilequeue"
node.override[:tilequeue][:seed][:log_dir] = "#{node[:path][:var]}/log/tilequeue"
node.override[:tilequeue][:user][:user] = 'vagrant'
node.override[:tilequeue][:tilediff][:script][:path] = "#{node[:path][:bin]}/tilequeue-tilediff.sh"
node.override[:tilequeue][:tilediff][:script][:output] = "#{node[:path][:var]}/log/tilequeue/tilediff.log"
node.override[:tilequeue][:tilediff][:lock][:pid] = "#{node[:path][:var]}/tilequeue-tilediff.pid"
