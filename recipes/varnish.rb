include_recipe 'apt'
apt_repository 'varnish-cache' do
  uri "http://repo.varnish-cache.org/#{node['platform']}"
  distribution node['lsb']['codename']
  components ["varnish-4.0"]
  key "http://repo.varnish-cache.org/#{node['platform']}/GPG-key.txt"
  deb_src true
  notifies 'nothing', 'execute[apt-get update]', 'immediately'
end

package 'varnish'

template '/etc/default/varnish' do
  source 'varnish_default.erb'
  owner 'root'
  group 'root'
  mode 0644
  notifies 'restart', 'service[varnish]', :delayed
end

template '/etc/varnish/default.vcl' do
  source 'varnish_default.vlc.erb'
  owner 'root'
  group 'root'
  mode 0644
  notifies :reload, 'service[varnish]', :delayed
end

service 'varnish' do
  supports restart: true, reload: true
  action %w(enable)
end

service 'varnishlog' do
  supports restart: true, reload: true
  action true ? %w(enable start) : %w(disable stop)
end
