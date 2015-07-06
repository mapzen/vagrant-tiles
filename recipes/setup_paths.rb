node[:path].each do |k, v|
  directory v do
    recursive true
  end
end

# implicit required directories under /.../var
%w(log pbf).each do |d|
  directory "#{node[:path][:var]}/#{d}"
end

directory "#{node[:path][:var]}/log/tilequeue"
