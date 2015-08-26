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
default[:git][:vector_datasource][:path] = "#{node[:path]}/opt/vector-datasource"

# frequency can be minute, hour, day
default[:update][:frequency] = 'minute'
default[:update][:max_seconds] = 3600
default[:update][:cron][:minute] = '*'
default[:update][:cron][:hour] = '*'
default[:update][:cron][:day] = '*'

require 'date'
date = Date.today
# get back to last saturday, which is when metro extracts run
while date.wday != 6 do
  date = date - 1
end
default[:update][:osmosis_state][:year] = date.year
default[:update][:osmosis_state][:month] = date.month
default[:update][:osmosis_state][:day] = date.day
default[:update][:osmosis_state][:hour] = 4
default[:update][:osmosis_state][:minute] = 0
default[:update][:osmosis_state][:second] = 0

node.override[:tilequeue][:cfg_path] = "#{node[:path]}/etc/tilequeue"
node.override[:tilequeue][:seed][:log_dir] = "#{node[:path]}/var/log/tilequeue"
node.override[:tilequeue][:user][:user] = 'vagrant'
node.override[:tilequeue][:user][:enabled] = false
node.override[:tilequeue][:intersect][:script][:path] = "#{node[:path]}/bin/tilequeue-intersect.sh"
node.override[:tilequeue][:intersect][:script][:output] = "#{node[:path]}/var/log/tilequeue/intersect.log"
node.override[:tilequeue][:intersect][:lock][:pid] = "#{node[:path]}/var/run/tilequeue/tilequeue-intersect.pid"
node.override[:tilequeue][:intersect][:cron][:minute] = '*'
node.override[:tilequeue][:intersect][:cron][:user] = 'vagrant'

node.override[:osm2pgsql][:version] = '0.0.1'
node.override[:osm2pgsql][:url] = 'https://github.com/rmarianski/osm2pgsql/archive/0.0.1.tar.gz'

node.override[:tilequeue][:queue][:type] = 'redis'
node.override[:tilequeue][:queue][:name] = 'tilequeue.queue'
node.override[:tilequeue][:store][:type] = 'directory'
node.override[:tilequeue][:store][:name] = "#{node[:path]}/var/tiles"
node.override[:tilequeue][:tiles][:all][:enabled] = false
node.override[:tilequeue][:tiles][:metro_extract][:enabled] = false
node.override[:tilequeue][:tiles][:top_tiles][:enabled] = false
node.override[:tilequeue][:tiles][:custom][:enabled] = true
node.override[:tilequeue][:tiles][:custom][:zoom_start] = 11
node.override[:tilequeue][:tiles][:custom][:zoom_until] = 15
node.override[:tilequeue][:tiles][:custom][:bboxes] = [[-74.501, 40.345, -73.226, 41.097]]
node.override[:tilequeue][:tiles][:should_add_to_tiles_of_interest] = true
node.override[:tilequeue][:tiles][:expired_location] = "#{node[:path]}/var/osm2pgsql/expired-tiles"
node.override[:tilequeue][:tiles][:parent_zoom_until] = 11

node.override[:tilequeue][:logging][:config] = "#{node[:path]}/etc/tilequeue/logging.conf"
node.override[:tilequeue][:postgresql][:host] = 'localhost'
node.override[:tilequeue][:postgresql][:dbnames] = [node[:pg][:dbname]]
node.override[:tilequeue][:postgresql][:user] = node[:pg][:user]
node.override[:tilequeue][:postgresql][:password] = node[:pg][:password]

node.override[:tilequeue][:vector_datasource][:path] = node[:git][:vector_datasource][:path]

node.override[:nginx][:port] = 8080
node.override[:nginx][:default_site_enabled] = false

default[:varnish][:port] = 80

default[:tileserver][:port] = 8000
default[:tileserver][:tilejson][:path] = '/srv/www/tileserver'
node.override[:tileserver][:postgresql][:dbnames] = [node[:pg][:dbname]]
node.override[:tileserver][:postgresql][:user] = node[:pg][:user]
node.override[:tileserver][:postgresql][:password] = node[:pg][:password]
node.override[:tileserver][:vector_datasource][:path] = node[:git][:vector_datasource][:path]
