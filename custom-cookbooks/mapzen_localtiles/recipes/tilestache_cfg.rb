template "#{node[:path][:bin]}/generate_tilestache_cfg.rb" do
  source 'generate_tilestache_cfg.rb.erb'
  mode    0755
end

execute 'generate tilestache cfg' do
  command "#{node[:path][:bin]}/generate_tilestache_cfg.rb"
  creates "#{node[:path][:etc]}/tilestache.cfg"
end
