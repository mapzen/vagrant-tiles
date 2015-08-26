git node[:git][:vector_datasource][:path] do
  repository node[:git][:vector_datasource][:url]
  revision node[:git][:vector_datasource][:branch]
end
