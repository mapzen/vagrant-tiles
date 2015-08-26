directory node[:path] if node[:path] != ''

# implicit required directories under /.../var
%w(log pbf osmosis expired-tiles tiles).each do |d|
  directory "#{node[:path]}/var/#{d}"
end

directory "#{node[:path]}/var/tiles" do
  owner 'vagrant'
end

# to allow writing gunicorn.log file and pids
%w(/var/log/osm2pgsql /var/log/tilequeue /var/log/osmosis /var/run/osm2pgsql /var/run/tilequeue /var/osmosis).each do |d|
  directory d do
    owner 'vagrant'
  end
end
directory node[:tilequeue][:tiles][:expired_location] do
  owner 'vagrant'
  recursive true
end
