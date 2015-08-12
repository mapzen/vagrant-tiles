template "#{node[:path]}/var/osmosis/configuration.txt" do
  source 'osmosis-configuration.txt.erb'
  mode 0755
end

template "#{node[:path]}/bin/osm-update.sh" do
  source 'osm-update.sh.erb'
  mode 0755
end

# fetch initial state.txt
remote_file "#{node[:path]}/var/osmosis/state.txt" do
  source  "http://osm.personalwerk.de/replicate-sequences/?\
Y=#{node[:update][:osmosis_state][:year]}&\
m=#{node[:update][:osmosis_state][:month]}&\
d=#{node[:update][:osmosis_state][:day]}&\
H=#{node[:update][:osmosis_state][:hour]}&\
i=#{node[:update][:osmosis_state][:minute]}&\
s=#{node[:update][:osmosis_state][:second]}&\
stream=#{node[:update][:frequency]}#"
  mode    0644
  not_if  { ::File.exist?("#{node[:path]}/var/osmosis/state.txt") }
end

cron 'osm update' do
  minute  node[:update][:cron][:minute]
  hour    node[:update][:cron][:hour]
  day     node[:update][:cron][:day]
  command "#{node[:path]}/bin/osm-update.sh >>#{node[:path]}/var/log/osm2pgsql/osm-update.log 2>&1"
  user    'vagrant'
end
