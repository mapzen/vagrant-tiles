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

default[:nginx][:port] = 8000

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
node.override[:tilequeue][:tilediff][:script][:output] = "#{node[:path][:var]}/log/tilediff.log"
node.override[:tilequeue][:tilediff][:lock][:pid] = "#{node[:path][:var]}/tilequeue-tilediff.pid"
node.override[:tilequeue][:tilediff][:cron][:minute] = '*'
node.override[:tilequeue][:tilediff][:cron][:user] = 'vagrant'

node.override[:osm2pgsql][:version] = '0.0.1'
node.override[:osm2pgsql][:url] = 'https://github.com/rmarianski/osm2pgsql/archive/0.0.1.tar.gz'

node.override[:tilequeue][:queue][:type] = 'redis'
node.override[:tilequeue][:queue][:name] = 'tilequeue.queue'
node.override[:tilequeue][:store][:type] = 'directory'
node.override[:tilequeue][:store][:name] = "#{node[:path][:var]}/tiles"
node.override[:tilequeue][:tiles][:all][:enabled] = false
node.override[:tilequeue][:tiles][:metro_extract][:enabled] = false
node.override[:tilequeue][:tiles][:top_tiles][:enabled] = false
node.override[:tilequeue][:tiles][:custom][:enabled] = true
node.override[:tilequeue][:tiles][:custom][:zoom_start] = 11
node.override[:tilequeue][:tiles][:custom][:zoom_until] = 15
node.override[:tilequeue][:tiles][:custom][:bboxes] = [[-74.501, 40.345, -73.226, 41.097]]
node.override[:tilequeue][:tiles][:should_add_to_tiles_of_interest] = true
node.override[:tilequeue][:tiles][:expired_location] = "#{node[:path][:var]}/expired-tiles"
node.override[:tilequeue][:tiles][:parent_zoom_until] = 11
node.override[:tilequeue][:tilestache][:formats] = %w(json topojson vtm mvt)
node.override[:tilequeue][:tilestache][:config] = "#{node[:path][:etc]}/tilestache/tilestache.cfg"
node.override[:tilequeue][:logging][:config] = "#{node[:path][:etc]}/tilequeue/logging.conf"
node.override[:tilequeue][:postgresql][:host] = 'localhost'
node.override[:tilequeue][:postgresql][:dbnames] = [node[:pg][:dbname]]
node.override[:tilequeue][:postgresql][:user] = node[:pg][:user]
node.override[:tilequeue][:postgresql][:password] = node[:pg][:password]

node.override[:tilestache][:gunicorn][:cfgbasedir] = "#{node[:path][:etc]}/tilestache"
node.override[:tilestache][:gunicorn][:workers] = 1
node.override[:tilestache][:user] = 'vagrant'
node.override[:tilestache][:cfg_path] = "#{node[:path][:etc]}/tilestache"
node.override[:tilestache][:cfg_file] = "tilestache.cfg"
