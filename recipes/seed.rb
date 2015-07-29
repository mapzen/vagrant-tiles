unless File.exists?("#{node[:path]}/var/did_seed_tiles")
  include_recipe 'vagrant-tiles::do_seed'

  # create file to prevent seeding tiles on future runs
  file "#{node[:path]}/var/did_seed_tiles" do
    action :touch
  end

end
