default[:pg][:dbname] = 'gis'
default[:pg][:user] = 'gisuser'
default[:pg][:password] = node['postgresql']['password']['postgres']

default[:pg][:conn_info] = {
  :host => "127.0.0.1",
  :port => 5432,
  :username => 'postgres',
  :password => node['postgresql']['password']['postgres']
}

default[:git][:vector_datasource][:url] = 'https://github.com/mapzen/vector-datasource.git'
default[:git][:vector_datasource][:branch] = 'master'

# frequency can be minute, hour, day
default[:update][:frequency] = 'minute'
default[:update][:max_seconds] = 3600
default[:update][:cron][:minute] = '*'
default[:update][:cron][:hour] = '*'
default[:update][:cron][:day] = '*'

# TODO hard coded for now, should do some date arithmetic to figure out last sunday
default[:update][:osmosis_state][:year] = '2015'
default[:update][:osmosis_state][:month] = '7'
default[:update][:osmosis_state][:day] = '5'
default[:update][:osmosis_state][:hour] = '4'
default[:update][:osmosis_state][:minute] = '0'
default[:update][:osmosis_state][:second] = '0'

node.override[:tilequeue][:cfg_path] = "#{node[:path][:etc]}/tilequeue"
node.override[:tilequeue][:seed][:log_dir] = "#{node[:path][:var]}/log/tilequeue"
node.override[:tilequeue][:user][:user] = 'vagrant'
node.override[:tilequeue][:tilediff][:script][:path] = "#{node[:path][:bin]}/tilequeue-tilediff.sh"
node.override[:tilequeue][:tilediff][:script][:output] = "#{node[:path][:var]}/log/tilequeue/tilediff.log"
node.override[:tilequeue][:tilediff][:lock][:pid] = "#{node[:path][:var]}/tilequeue-tilediff.pid"

node.override[:osm2pgsql][:version] = '0.0.1'
node.override[:osm2pgsql][:url] = 'https://github.com/rmarianski/osm2pgsql/archive/0.0.1.tar.gz'
