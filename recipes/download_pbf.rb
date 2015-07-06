remote_file "#{node[:path][:var]}/pbf/#{node[:pbf][:name]}" do
  source node[:pbf][:url]
end
