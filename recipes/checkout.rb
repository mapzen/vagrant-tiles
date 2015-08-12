git "#{node[:path]}/opt/vector-datasource" do
  repository node[:git][:vector_datasource][:url]
  revision node[:git][:vector_datasource][:branch]
end
