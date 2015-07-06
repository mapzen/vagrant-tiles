unless File.exists?("#{node[:path][:var]}/did_setup_database")

  include_recipe 'vagrant-tiles::create_database'

  include_recipe 'vagrant-tiles::download_pbf'

  # load_db_data is not idempotent
  include_recipe 'vagrant-tiles::load_db_data'

  # create file to prevent setting up database on future runs
  file "#{node[:path][:var]}/did_setup_database" do
    action :touch
  end

end
