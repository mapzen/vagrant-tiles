git "#{node[:path]}/src/vector-datasource" do
  repository node[:git][:vector_datasource][:url]
  revision node[:git][:vector_datasource][:branch]
end
