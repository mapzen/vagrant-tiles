node[:path].each do |k, v|
  directory v do
    recursive true
  end
end

# implicit required directories under /.../var
%w(log pbf osmosis expired-tiles tiles).each do |d|
  directory "#{node[:path][:var]}/#{d}"
end
