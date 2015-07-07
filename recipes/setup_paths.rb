node[:path].each do |k, v|
  directory v do
    recursive true
  end
end

# implicit required directories under /.../var
%w(log pbf osmosis expired-tiles tiles).each do |d|
  directory "#{node[:path][:var]}/#{d}"
end

directory "#{node[:path][:etc]}/tilestache"

# to allow writing gunicorn.log file and pids
%w(/var/log/tilestache /var/log/tilestache/pids).each do |d|
  directory d do
    owner 'vagrant'
  end
end
